import pytest
from pathlib import Path

from conftest import assert_command_succeeded


@pytest.mark.bootstrap
def test_yadm_bootstrap(run_logged_command):
    """yadm bootstrap finishes successfully and writes its completion marker."""
    bootstrap_marker = Path("/tmp/yadm-bootstrap")

    result = run_logged_command(
        command="yadm bootstrap",
        log_name="yadm-bootstrap.log",
        timeout=120,
    )

    assert_command_succeeded(result, action="yadm bootstrap", log_name="yadm-bootstrap.log")

    assert bootstrap_marker.exists(), (
        f"Expected bootstrap marker to exist: {bootstrap_marker}"
    )

    marker_content = bootstrap_marker.read_text()
    assert "finished" in marker_content, (
        f"Expected bootstrap marker to contain 'finished', got: {marker_content!r}"
    )
