# colcon-python-project-example

An example of a workspace and packages for [colcon-python-project](https://github.com/colcon/colcon-python-project/tree/devel).
For more information, see the [Call For Testing: Standards-based Python packaging with colcon](https://discourse.ros.org/t/call-for-testing-standards-based-python-packaging-with-colcon/32008).

This repository aims to implement minimum examples the following scenarios listed below.

| Description                                           | Status                                                                                                            |
|-------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Standalone packages utilizing pytest and unittest     | Minimal setuptools implementation, PEP 517 implementation for standalone pytest package available with some TODOs |
| Inter package dependencies                            | Minimal setuptools implementation, PEP 517 implementation missing                                                 |
| Providing pytest plugins and fixtures across packages | Minimal setuptools implementation, PEP 517 implementation missing                                                 |
| Providing python source trees for other packages      | Implemented but not explicit tests                                                                                |

The packages should be able to be built with merge and symlink installs, as well as regular builds and work with PEP 517.

## Install colcon-python-project

In order to get started with colcon-python-project run the following commands to checkout its repository and install its dependencies:
```bash
git clone https://github.com/colcon/colcon-python-project.git -b devel src/colcon-python-project
sudo apt-get install -y python3-tomli python3-pytest-cov python3-pytest-benchmark python3-pep8-naming python3-poetry pylint 
pip install scspell3k
```

Build the workspace and source it:
```bash
colcon build
. /install/local_setup.bash
```

Verify the installation. The extension is active if you see `python.project` and `ros.ament_python.project` packages:
```shell
colcon list
```

## Open questions

How to install package markers to avoid these:
```shell
[0.597s] WARNING:colcon.colcon_ros.task.ament_python.build:Package 'pep517_standalone_example_pytest' doesn't explicitly install a marker in the package index (colcon-ros currently does it implicitly but that fallback will be removed in the future)
[0.598s] WARNING:colcon.colcon_ros.task.ament_python.build:Package 'pep517_standalone_example_pytest' doesn't explicitly install the 'package.xml' file (colcon-ros currently does it implicitly but that fallback will be removed in the future)
```