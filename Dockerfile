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
    pip install scspell3k>=2.2 && \
    rm -rf /var/lib/apt/lists/

COPY src/standalone_example_pytest src/standalone_example_pytest
COPY src/standalone_example_unittest src/standalone_example_unittest

RUN apt-get update && \
    rosdep install -iy --from-paths src && \
    rm -rf /var/lib/apt/lists/
 
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build $COLCON_BUILD_ARGS --continue-on-error
 
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon list ; \
    colcon test --packages-skip colcon-python-project --event-handlers console_direct+ ; \
    colcon test-result --verbose

RUN sed --in-place --expression \
    '$isource "${ROS_OVERLAY}/install/setup.bash"' \
    /ros_entrypoint.sh
