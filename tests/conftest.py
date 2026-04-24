import os
import subprocess
import pytest
from pathlib import Path


@pytest.fixture
def run_command():
    """Helper for subprocess calls with timeout"""
    def _run(cmd, timeout=30, check=False, capture=True, env=None):
        # Ensure ~/.local/bin is in PATH so locally installed tools (e.g. nvim) are found
        if env is None:
            env = os.environ.copy()
        local_bin = str(Path.home() / ".local" / "bin")
        if local_bin not in env.get("PATH", ""):
            env["PATH"] = local_bin + os.pathsep + env.get("PATH", "")

        kwargs = {
            "shell": True,
            "timeout": timeout,
            "env": env,
        }
        if capture:
            kwargs.update({"capture_output": True, "text": True})

        result = subprocess.run(cmd, **kwargs)
        if check and result.returncode != 0:
            raise AssertionError(f"Command failed: {cmd}\n{result.stderr}")
        return result
    return _run


@pytest.fixture
def artifact_dir():
    """Directory for test artifacts/logs"""
    path = Path("/home/testuser/.test_results")
    path.mkdir(exist_ok=True)
    return path


@pytest.fixture
def wait_until():
    """Poll-based waiting instead of sleep"""
    import time
    def _wait(predicate, timeout=10, interval=0.5, error_msg="Timeout"):
        start = time.time()
        while time.time() - start < timeout:
            if predicate():
                return True
            time.sleep(interval)
        raise TimeoutError(error_msg)
    return _wait


@pytest.fixture
def run_logged_command(run_command, artifact_dir):
    """Run a shell command and write its output to a log file in artifact_dir."""
    def _run(*, command: str, log_name: str, timeout: int, env=None):
        result = run_command(command, timeout=timeout, env=env)
        (artifact_dir / log_name).write_text(f"{result.stdout}\n\nSTDERR:\n{result.stderr}")
        return result
    return _run


def assert_command_succeeded(result, *, action: str, log_name: str) -> None:
    assert result.returncode == 0, (
        f"{action} failed with exit code {result.returncode}. "
        f"See {log_name} for details."
    )


def assert_file_exists(path: Path, description: str) -> None:
    assert path.exists(), f"Expected {description} to exist: {path}"


def assert_executable_exists(path: Path, description: str) -> None:
    assert path.exists(), f"Expected {description} to exist: {path}"
    assert path.is_file(), f"Expected {description} to be a file: {path}"
    assert os.access(path, os.X_OK), f"Expected {description} to be executable: {path}"
