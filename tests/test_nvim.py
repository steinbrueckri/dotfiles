import os
import re
from pathlib import Path

import pytest


BOB_NVIM_BIN = Path.home() / ".local/share/bob/nightly/bin"


@pytest.fixture
def nvim_env() -> dict[str, str]:
    """Environment with Neovim installed via bob available on PATH."""
    env = os.environ.copy()
    env["PATH"] = f"{BOB_NVIM_BIN}:{env['PATH']}"
    return env


def write_command_log(
    artifact_dir: Path,
    filename: str,
    stdout: str,
    stderr: str,
) -> None:
    """Write command output to an artifact log for debugging."""
    (artifact_dir / filename).write_text(f"{stdout}\n\nSTDERR:\n{stderr}")


def run_logged_command(
    run_command,
    artifact_dir: Path,
    *,
    command: str,
    log_name: str,
    timeout: int,
    env: dict[str, str] | None = None,
):
    """Run a command and store its output as a test artifact."""
    result = run_command(command, timeout=timeout, env=env)
    write_command_log(artifact_dir, log_name, result.stdout, result.stderr)
    return result


def assert_command_succeeded(result, *, action: str, log_name: str) -> None:
    """Assert that a command completed successfully."""
    assert result.returncode == 0, (
        f"{action} failed with exit code {result.returncode}. "
        f"See {log_name} for details."
    )


def assert_file_exists(path: Path, description: str) -> None:
    """Assert that an expected file exists."""
    assert path.exists(), f"Expected {description} to exist: {path}"


@pytest.mark.bootstrap
@pytest.mark.slow
def test_lazy_sync(run_command, artifact_dir, nvim_env):
    """Lazy sync completes successfully and bootstraps required files."""
    result = run_logged_command(
        run_command,
        artifact_dir,
        command='nvim --headless "+Lazy! sync" +qall!',
        log_name="lazy-sync.log",
        timeout=500,
        env=nvim_env,
    )

    assert_command_succeeded(
        result,
        action="Lazy sync",
        log_name="lazy-sync.log",
    )

    home = Path.home()
    expected_files = [
        (home / ".config/nvim/lazy-lock.json", "lazy lock file"),
        (
            home / ".local/share/nvim/lazy/lazy.nvim/bootstrap.lua",
            "lazy.nvim bootstrap file",
        ),
        (
            home / ".local/share/nvim/lazy/telescope.nvim/lua/telescope/init.lua",
            "telescope.nvim entrypoint",
        ),
    ]

    for path, description in expected_files:
        assert_file_exists(path, description)


@pytest.mark.slow
def test_treesitter_install(artifact_dir):
    """Tree-sitter parsers were installed automatically during first startup."""
    parser_dir = Path.home() / ".local/share/nvim/site/parser"
    parsers = list(parser_dir.glob("*.so"))
    assert len(parsers) > 0, (
        f"Expected tree-sitter parsers in {parser_dir}, but none were found"
    )


@pytest.mark.slow
@pytest.mark.flaky(reruns=3, reruns_delay=2)
@pytest.mark.parametrize(
    "package",
    ["stylua", "jq", "black", "isort", "yamlfmt", "rumdl", "pylint"],
)
def test_mason_install(package, run_command, artifact_dir, nvim_env):
    """Mason installs required tools successfully."""
    log_name = f"mason-{package}.log"

    result = run_logged_command(
        run_command,
        artifact_dir,
        command=f'nvim --headless "+MasonInstall {package} --force" +qall!',
        log_name=log_name,
        timeout=120,
        env=nvim_env,
    )

    assert_command_succeeded(
        result,
        action=f"Mason install for {package}",
        log_name=log_name,
    )


@pytest.mark.integration
def test_checkhealth(run_command, artifact_dir, nvim_env):
    """Neovim health check reports expected healthy components."""
    result = run_logged_command(
        run_command,
        artifact_dir,
        command='nvim --headless "+checkhealth" "+w! health.log" +qa',
        log_name="checkhealth-command.log",
        timeout=60,
        env=nvim_env,
    )

    assert_command_succeeded(
        result,
        action="Neovim checkhealth",
        log_name="checkhealth-command.log",
    )

    health_log = Path("health.log").read_text()
    (artifact_dir / "checkhealth.log").write_text(health_log)

    assert re.search(r"OK Parser", health_log), (
        "Expected parser health check to report OK"
    )

    assert "rg" in health_log or "ripgrep" in health_log, (
        "Expected ripgrep to be mentioned in the health check output"
    )

    critical_error_patterns = [
        r"ERROR.*stylua.*not executable",
        r"ERROR.*black.*not executable",
    ]

    for pattern in critical_error_patterns:
        assert not re.search(pattern, health_log), (
            f"Found critical health check error matching pattern: {pattern}"
        )


@pytest.mark.integration
def test_startup_time(run_command, artifact_dir, nvim_env):
    """Neovim startup time stays below the agreed threshold."""
    result = run_logged_command(
        run_command,
        artifact_dir,
        command="vim-startuptime -vimpath nvim",
        log_name="vim-startuptime.log",
        timeout=60,
        env=nvim_env,
    )

    assert_command_succeeded(
        result,
        action="vim-startuptime",
        log_name="vim-startuptime.log",
    )

    match = re.search(r"Total Average:\s+([\d.]+)", result.stdout)
    assert match, (
        "Could not parse total average startup time from vim-startuptime output"
    )

    total_average_ms = float(match.group(1))
    limit_ms = 150.0

    assert total_average_ms < limit_ms, (
        f"Startup time {total_average_ms} ms exceeds limit {limit_ms} ms"
    )


@pytest.mark.integration
def test_nvim_headless_no_errors(run_command, artifact_dir, nvim_env):
    """Neovim starts in headless mode without reporting startup errors."""
    result = run_logged_command(
        run_command,
        artifact_dir,
        command='nvim --headless "+qall!"',
        log_name="nvim-headless.log",
        timeout=30,
        env=nvim_env,
    )

    assert_command_succeeded(
        result,
        action="Neovim headless startup",
        log_name="nvim-headless.log",
    )

    output = f"{result.stdout}\n{result.stderr}"
    error_patterns = [
        "Error detected",
        "Error:",
        "E5113",
        "traceback",
        "Trace",
        "failed",
    ]

    for pattern in error_patterns:
        assert pattern not in output, (
            f"Found startup error pattern {pattern!r} in nvim output"
        )
