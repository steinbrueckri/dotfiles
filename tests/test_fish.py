import pytest
from pathlib import Path


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
    assert len(plugin_dirs) > 0, (
        f"At least one plugin should be installed in {fundle_dir}"
    )
