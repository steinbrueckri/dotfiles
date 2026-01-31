import pytest


@pytest.mark.smoke
def test_yadm_installed(run_command):
    result = run_command("yadm --version")
    assert result.returncode == 0


@pytest.mark.smoke
def test_fish_installed(run_command):
    result = run_command("fish --version")
    assert result.returncode == 0


@pytest.mark.smoke
def test_nvim_installed(run_command):
    result = run_command("nvim --version")
    assert result.returncode == 0


@pytest.mark.smoke
def test_tmux_installed(run_command):
    result = run_command("tmux -V")
    assert result.returncode == 0
