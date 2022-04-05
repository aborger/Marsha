cmake_minimum_required(VERSION 3.0.2)
project(marsha_core)


find_package(catkin REQUIRED
  COMPONENTS
    roscpp
    rospy
    std_msgs
)

catkin_package()

catkin_install_python(
  PROGRAMS
    scripts/pickup_moving_object
    scripts/execute_grasp
    scripts/obj_measure
    scripts/btn
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
