from _pytest.config import PytestPluginManager


def no_plugin():
    plugin_manager = PytestPluginManager()
    assert plugin_manager.get_plugin("example_pytest_plugin") is None
