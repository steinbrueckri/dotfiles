import os
import pytest
import libtmux
from pathlib import Path


@pytest.fixture
def tmux_server():
    """Managed tmux server with automatic cleanup"""
    server = libtmux.Server()
    yield server
    # Cleanup: Kill all sessions we created
    for session in server.sessions:
        session.kill()


@pytest.mark.integration
def test_tpm_bootstrap(tmux_server, wait_until):
    """Test that TPM is installed and can install plugins"""
    home = Path.home()
    tpm_dir = home / ".tmux/plugins/tpm"
    
    # Start tmux session (triggers .tmux.conf which should auto-install TPM)
    session = tmux_server.new_session(session_name="tpm-test", attach=False)
    
    # Wait for TPM auto-install from .tmux.conf
    wait_until(
        lambda: (tpm_dir / "README.md").exists(),
        timeout=30,
        interval=1,
        error_msg="TPM should be auto-installed by .tmux.conf"
    )
    
    # Verify TPM is installed
    assert (tpm_dir / "tpm").exists(), "TPM executable should exist"
    assert (tpm_dir / "tpm").is_file() and os.access(tpm_dir / "tpm", os.X_OK), "TPM executable is executable"
    
    # Install plugins using tpm script
    session.active_window.active_pane.send_keys('.tmux/plugins/tpm/scripts/install_plugins.sh')
    
    # Define expected plugin paths
    # rose-pine/tmux → .tmux/plugins/tmux/rose-pine.tmux
    # fernandoflorez/tmux-tailscale → .tmux/plugins/tmux-tailscale/tailscale_status.tmux
    # tmux-plugins/tmux-battery → .tmux/plugins/tmux-battery/battery.tmux
    plugins_dir = home / ".tmux/plugins"
    expected_plugins = {
        "tmux": "rose-pine.tmux",
        "tmux-tailscale": "tailscale_status.tmux", 
        "tmux-battery": "battery.tmux",
    }
    
    # Wait for plugins to be installed
    wait_until(
        lambda: all((plugins_dir / plugin_dir).exists() for plugin_dir in expected_plugins.keys()),
        timeout=60,
        interval=2,
        error_msg="Plugins should be installed by TPM"
    )
    
    # Verify that each plugin's main file exists and is executable
    for plugin_dir, main_file in expected_plugins.items():
        plugin_path = plugins_dir / plugin_dir / main_file
        assert plugin_path.exists(), f"{plugin_dir}/{main_file} should exist"
        assert plugin_path.is_file() and os.access(plugin_path, os.X_OK), f"{plugin_dir}/{main_file} should be executable"
    
    session.kill()


@pytest.mark.integration
def test_tmux_send_keys_capture(tmux_server):
    session = tmux_server.new_session(session_name="capture-test", attach=False)
    pane = session.active_window.active_pane
    
    pane.send_keys('echo "Hello, World!"')
    
    # Brief wait for output (libtmux manages this better than raw tmux)
    import time
    time.sleep(0.5)
    
    output = pane.capture_pane()
    assert any("Hello, World!" in line for line in output)
