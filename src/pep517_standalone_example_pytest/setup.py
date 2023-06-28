from setuptools import setup

package_name = 'pep517_standalone_example_pytest'

setup(data_files=[
    ('share/ament_index/resource_index/packages',
     ['resource/' + package_name]),
    ('share/' + package_name, ['package.xml']),
])
