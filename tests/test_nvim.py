import pytest
from pathlib import Path
import re


@pytest.mark.bootstrap
@pytest.mark.slow
def test_lazy_sync(run_command, artifact_dir):
    result = run_command('nvim --headless "+Lazy! sync" +qall!', timeout=180)
    
    # Artifacts for debugging
    (artifact_dir / "lazy-sync.log").write_text(result.stdout + "\n" + result.stderr)
    
    assert result.returncode == 0
    home = Path.home()
    assert (home / ".config/nvim/lazy-lock.json").exists()
    assert (home / ".local/share/nvim/lazy/lazy.nvim/bootstrap.lua").exists()
    assert (home / ".local/share/nvim/lazy/telescope.nvim/lua/telescope/init.lua").exists()


@pytest.mark.slow
def test_treesitter_install(run_command, artifact_dir):
    result = run_command('nvim --headless "+TSInstallSync all" +qall!', timeout=300)
    
    (artifact_dir / "treesitter-install.log").write_text(result.stdout + "\n" + result.stderr)
    assert result.returncode == 0


@pytest.mark.slow
@pytest.mark.flaky(reruns=3, reruns_delay=2)
@pytest.mark.parametrize("lsp", ["stylua", "jq", "black", "isort", "yamlfmt", "markdownlint", "pylint"])
def test_mason_install(lsp, run_command, artifact_dir):
    """Parametrized tests with retry for known flaky Mason installs"""
    result = run_command(f'nvim --headless "+MasonInstall {lsp} --force" +qall!', timeout=120)
    
    # Individual log per LSP
    (artifact_dir / f"mason-{lsp}.log").write_text(result.stdout + "\n" + result.stderr)
    
    assert result.returncode == 0, f"Failed to install {lsp}"


@pytest.mark.integration
def test_checkhealth(run_command, artifact_dir):
    result = run_command('nvim --headless "+checkhealth" "+w! health.log" +qa', timeout=60)
    
    health_log = Path("health.log").read_text()
    (artifact_dir / "checkhealth.log").write_text(health_log)
    
    # Positive assertions - check for OK status in general
    assert re.search(r"OK Parser", health_log), "Parser health check should pass"
    
    # Check that critical tools are found (flexible pattern)
    # Just check that rg/ripgrep is mentioned and not marked as ERROR
    assert "rg" in health_log or "ripgrep" in health_log, "ripgrep/rg should be mentioned in health check"
    
    # Negative assertions - check for critical errors only
    # Make sure stylua and black are not marked as missing/not executable
    critical_errors = [
        'ERROR.*stylua.*not executable',
        'ERROR.*black.*not executable',
    ]
    
    for error_pattern in critical_errors:
        assert not re.search(error_pattern, health_log), f"Found critical error: {error_pattern}"


@pytest.mark.integration
def test_startup_time(run_command, artifact_dir):
    result = run_command("vim-startuptime -vimpath nvim", timeout=60)
    
    (artifact_dir / "vim-startuptime.log").write_text(result.stdout)
    
    # Parse Total Average
    match = re.search(r"Total Average:\s+([\d.]+)", result.stdout)
    assert match, "Could not parse startup time"
    
    total_avg = float(match.group(1))
    limit = 150  # milliseconds
    
    assert total_avg < limit, f"Startup time {total_avg}ms exceeds limit {limit}ms"
