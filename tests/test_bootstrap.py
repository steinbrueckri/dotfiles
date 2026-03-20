import pytest
from pathlib import Path


@pytest.mark.bootstrap
def test_yadm_bootstrap(run_command, artifact_dir):
    """yadm bootstrap finishes successfully and writes its completion marker."""
    bootstrap_marker = Path("/tmp/yadm-bootstrap")

    result = run_command("yadm bootstrap", timeout=120)
    write_bootstrap_log(artifact_dir, result.stdout, result.stderr)

    assert result.returncode == 0, (
        f"yadm bootstrap failed with exit code {result.returncode}. "
        "See yadm-bootstrap.log for details."
    )

    assert bootstrap_marker.exists(), (
        f"Expected bootstrap marker to exist: {bootstrap_marker}"
    )

    marker_content = bootstrap_marker.read_text()
    assert "finished" in marker_content, (
        f"Expected bootstrap marker to contain 'finished', got: {marker_content!r}"
    )


def write_bootstrap_log(artifact_dir: Path, stdout: str, stderr: str) -> None:
    """Write bootstrap command output to an artifact log for debugging."""
    log_path = artifact_dir / "yadm-bootstrap.log"
    log_path.write_text(f"{stdout}\n\nSTDERR:\n{stderr}")
