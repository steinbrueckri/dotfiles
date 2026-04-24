import time
from pathlib import Path

import libtmux
import pytest

from conftest import assert_command_succeeded, assert_executable_exists


@pytest.fixture
def tmux_server():
    """Managed tmux server with automatic cleanup."""
    server = libtmux.Server()
    yield server

    for session in server.sessions:
        session.kill()


@pytest.fixture
def tpm_bootstrapped(tmux_server, wait_until) -> Path:
    """Ensure TPM is bootstrapped via tmux and available on disk."""
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
        return tpm_executable
    finally:
        session.kill()


@pytest.mark.integration
def test_tpm_bootstrap(tpm_bootstrapped):
    """TPM is bootstrapped automatically when tmux loads .tmux.conf."""
    assert_executable_exists(tpm_bootstrapped, "TPM executable")


@pytest.mark.integration
def test_tpm_install(tpm_bootstrapped, run_logged_command, wait_until):
    """TPM install script installs the configured tmux plugins."""
    plugins_dir = Path.home() / ".tmux/plugins"
    tpm_repo_dir = tpm_bootstrapped.parent
    install_script = tpm_repo_dir / "bin/install"

    expected_plugins = {
        "tmux": "rose-pine.tmux",
        "tmux-battery": "battery.tmux",
        "tmux-fingers": "tmux-fingers.tmux",
    }

    assert_executable_exists(install_script, "TPM install script")

    result = run_logged_command(
        command=str(install_script),
        log_name="tpm-install.log",
        timeout=120,
    )

    assert_command_succeeded(result, action="TPM install script", log_name="tpm-install.log")

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
        time.sleep(0.5)

        output = pane.capture_pane()
        assert any("Hello, World!" in line for line in output), (
            "Expected pane output to contain 'Hello, World!'"
        )
    finally:
        session.kill()
