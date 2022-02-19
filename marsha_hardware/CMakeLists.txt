cmake_minimum_required(VERSION 3.0.2)
project(marsha_hardware)

find_package(catkin REQUIRED
    COMPONENTS
        roscpp
        rospy
        std_msgs
)

catkin_package()

catkin_install_python(
    PROGRAMS
        scripts/serial_test.py
        DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)