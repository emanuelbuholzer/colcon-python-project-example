import pytest


@pytest.hookimpl()
def pytest_addoption(parser):
    parser.addoption("--hello", action="store_true", help="just a dummy", required=False)
