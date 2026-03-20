import os
from pathlib import Path

import libtmux
import pytest


@pytest.fixture
def tmux_server():
    """Managed tmux server with automatic cleanup."""
    server = libtmux.Server()
    yield server

    for session in server.sessions:
        session.kill()


def assert_executable_exists(path: Path, description: str) -> None:
    """Assert that a file exists and is executable."""
    assert path.exists(), f"Expected {description} to exist: {path}"
    assert path.is_file(), f"Expected {description} to be a file: {path}"
    assert os.access(path, os.X_OK), f"Expected {description} to be executable: {path}"


@pytest.mark.integration
def test_tpm_bootstrap(tmux_server, wait_until):
    """TPM is bootstrapped automatically when tmux loads .tmux.conf."""
    tpm_executable = Path.home() / ".tmux/plugins/tpm-redux/tpm"

    session = tmux_server.new_session(session_name="tpm-bootstrap-test", attach=False)

    try:
        wait_until(
            lambda: tpm_executable.exists(),
            timeout=60,
            interval=1,
            error_msg="Expected TPM to be auto-installed via .tmux.conf",
        )

        assert_executable_exists(tpm_executable, "TPM executable")
    finally:
        session.kill()


@pytest.mark.integration
def test_tpm_install(run_command, wait_until, artifact_dir):
    """TPM install script installs the configured tmux plugins."""
    home = Path.home()
    plugins_dir = home / ".tmux/plugins"
    install_script = plugins_dir / "tpm-redux/tpm/bin/install"

    expected_plugins = {
        "tmux": "rose-pine.tmux",
        "tmux-battery": "battery.tmux",
        "tmux-fingers": "fingers.tmux",
    }

    assert_executable_exists(install_script, "TPM install script")

    result = run_command(str(install_script), timeout=120)

    (artifact_dir / "tpm-install.log").write_text(
        f"{result.stdout}\n\nSTDERR:\n{result.stderr}"
    )

    assert result.returncode == 0, (
        f"TPM install script failed with exit code {result.returncode}. "
        "See tpm-install.log for details."
    )

    wait_until(
        lambda: all(
            (plugins_dir / plugin_dir).exists() for plugin_dir in expected_plugins
        ),
        timeout=60,
        interval=2,
        error_msg="Expected TPM to install all configured plugins",
    )

    for plugin_dir, main_file in expected_plugins.items():
        plugin_entrypoint = plugins_dir / plugin_dir / main_file
        assert_executable_exists(
            plugin_entrypoint,
            f"plugin entrypoint {plugin_dir}/{main_file}",
        )


@pytest.mark.integration
def test_tmux_send_keys_capture(tmux_server):
    """tmux pane input can be captured from the active pane."""
    session = tmux_server.new_session(session_name="capture-test", attach=False)
    pane = session.active_window.active_pane

    try:
        pane.send_keys('echo "Hello, World!"')

        import time

        time.sleep(0.5)

        output = pane.capture_pane()
        assert any("Hello, World!" in line for line in output), (
            "Expected pane output to contain 'Hello, World!'"
        )
    finally:
        session.kill()
