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

catkin_python_setup()

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
        nodes/mission_sm
        nodes/left_pcs
        nodes/right_pcs
        nodes/te_detect
        nodes/soft_robotics_telem
        nodes/telemetry_downlink
        nodes/record_longeron
        scripts/motor.py
        scripts/throw
        scripts/follow_ball
        scripts/catch
        scripts/joint_radians
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

add_executable(move_interface nodes/move_interface.cpp)
target_link_libraries(move_interface ${catkin_LIBRARIES})
add_dependencies(move_interface marsha_msgs_generate_messages_cpp)