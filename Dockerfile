ARG ROS_DISTRO="humble"
ARG COLCON_BUILD_ARGS="--symlink-install"
FROM docker.io/ros:${ROS_DISTRO}

# See https://github.com/opencontainers/runc/issues/2517
RUN echo 'APT::Sandbox::User "root";' > /etc/apt/apt.conf.d/sandbox-disable

ENV ROS_OVERLAY /opt/ros/example_ws

WORKDIR $ROS_OVERLAY

# Setup colcon-python-project
RUN git clone https://github.com/colcon/colcon-python-project.git -b devel src/colcon-python-project && \
    apt-get update && \
    apt-get install -y \
    python3-pip \
    python3-tomli  \
    python3-pytest-cov \
    python3-pytest-benchmark \
    python3-pep8-naming \
    python3-poetry \
    pylint \
    && \
    pip install scspell3k && \
    rm -rf /var/lib/apt/lists/

COPY src/standalone_example_pytest src/standalone_example_pytest
COPY src/standalone_example_unittest src/standalone_example_unittest
COPY src/example_library src/example_library
COPY src/example_library_dependent src/example_library_dependent
COPY src/example_pytest_plugin src/example_pytest_plugin
COPY src/example_pytest_plugin_dependent src/example_pytest_plugin_dependent
COPY src/pep517_standalone_example_pytest src/pep517_standalone_example_pytest
COPY src/pep517_standalone_example_unittest src/pep517_standalone_example_unittest
COPY src/pep517_example_library src/pep517_example_library
COPY src/pep517_example_library_dependent src/pep517_example_library_dependent

RUN apt-get update && \
    rosdep install -iy --from-paths src && \
    rm -rf /var/lib/apt/lists/
 
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon --log-level info build $COLCON_BUILD_ARGS --continue-on-error --event-handlers console_direct+
 
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon list ; \
    colcon --log-level info test --packages-skip colcon-python-project --event-handlers console_direct+ ; \
    colcon test-result --verbose

RUN sed --in-place --expression \
    '$isource "${ROS_OVERLAY}/install/setup.bash"' \
    /ros_entrypoint.sh
