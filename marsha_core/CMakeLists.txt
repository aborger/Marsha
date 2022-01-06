cmake_minimum_required(VERSION 3.0.2)
project(marsha_core)


find_package(catkin REQUIRED
  COMPONENTS
    roscpp
    rospy
    std_msgs
    ar_mini_description
)

catkin_package()

catkin_install_python(
  PROGRAMS
    scripts/pickup_moving_object
    scripts/execute_grasp
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
