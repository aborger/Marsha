cmake_minimum_required(VERSION 3.0.2)
project(marsha_core)


find_package(catkin REQUIRED
    COMPONENTS
        roscpp
        rospy
        std_msgs
        geometry_msgs
        moveit_core
        moveit_ros_planning
        moveit_ros_planning_interface
        marsha_msgs
        tf
)

include_directories(include)

catkin_package(
    CATKIN_DEPENDS
      moveit_core
      moveit_ros_planning_interface
      marsha_msgs
)

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)

catkin_install_python(
    PROGRAMS
        scripts/motor.py
        scripts/throw
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

add_executable(move_interface nodes/move_interface.cpp)
target_link_libraries(move_interface ${catkin_LIBRARIES})
add_dependencies(move_interface marsha_msgs_generate_messages_cpp)