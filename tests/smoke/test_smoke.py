import pytest
from src.app import add

@pytest.mark.smoke
def test_smoke_add_is_fast():
    assert add(2, 2) == 4
