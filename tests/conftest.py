import subprocess
import pytest
from pathlib import Path


@pytest.fixture
def run_command():
    """Helper for subprocess calls with timeout"""
    def _run(cmd, timeout=30, check=False, capture=True, env=None):
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
