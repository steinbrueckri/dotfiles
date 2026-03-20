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


