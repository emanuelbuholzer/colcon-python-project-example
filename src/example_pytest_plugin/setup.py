from setuptools import setup

package_name = 'example_pytest_plugin'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='oxb',
    maintainer_email='emanuel0xb@gmail.com',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
        ],
        'pytest11': [
            'example_pytest_plugin = example_pytest_plugin'
        ]
    },
)
