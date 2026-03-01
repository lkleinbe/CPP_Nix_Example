"""Tests for the addition module."""

from src_py.addition import add


def test_demo0():
    """Basic sanity test."""
    assert 1 == 1


def test_demo1():
    """Test the add function."""
    assert add(1, 1) == 2
