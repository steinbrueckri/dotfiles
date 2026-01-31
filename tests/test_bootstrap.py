import pytest
from pathlib import Path


@pytest.mark.bootstrap
def test_yadm_bootstrap(run_command, artifact_dir):
    result = run_command("yadm bootstrap", timeout=120)
    
    # Write log for debugging
    (artifact_dir / "yadm-bootstrap.log").write_text(result.stdout + "\n\nSTDERR:\n" + result.stderr)
    
    assert result.returncode == 0, f"Bootstrap failed with return code {result.returncode}. Check yadm-bootstrap.log for details."
    bootstrap_marker = Path("/tmp/yadm-bootstrap")
    assert bootstrap_marker.exists()
    assert "finished" in bootstrap_marker.read_text()


@pytest.mark.bootstrap
def test_fundle_install(run_command):
    result = run_command("fish -c 'fundle install'", timeout=60)
    
    assert result.returncode == 0
    assert "Unknown command" not in result.stdout
    
    # Check plugin installation
    home = Path.home()
    fundle_dir = home / ".config/fish/fundle"
    assert fundle_dir.exists(), "Fundle directory should exist"
    
    # Check at least one plugin was installed
    plugin_dirs = list(fundle_dir.glob("*/*"))
    assert len(plugin_dirs) > 0, f"At least one plugin should be installed in {fundle_dir}"
