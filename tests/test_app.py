import pytest
from src.app import add, divide

@pytest.mark.regression
@pytest.mark.parametrize("a,b,expected", [
    (1, 2, 3),
    (-1, 1, 0),
    (2.5, 0.5, 3.0),
])
def test_add(a, b, expected):
    assert add(a, b) == expected


@pytest.mark.regression
@pytest.mark.parametrize("a,b,expected", [
    (10, 2, 5),
    (9, 3, 3),
])
def test_divide(a, b, expected):
    assert divide(a, b) == expected


def test_divide_by_zero():
    with pytest.raises(ValueError):
        divide(1, 0)
