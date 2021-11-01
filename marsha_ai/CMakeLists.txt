cmake_minimum_required(VERSION 3.0.2)
project(marsha_ai)


find_package(catkin REQUIRED
  COMPONENTS
    message_generation
    roscpp
    rospy
    std_msgs
    geometry_msgs
    trajectory_msgs
    rosbridge_server
    interactive_markers
    moveit_core
    moveit_visual_tools
    moveit_ros_planning
    moveit_ros_planning_interface
    moveit_ros_perception
    pluginlib
    geometric_shapes
    pcl_ros
    pcl_conversions
    rosbag
    tf2_ros
    tf2_eigen
    tf2_geometry_msgs
    marsha_msgs
)



catkin_python_setup()




 

catkin_package(
  LIBRARIES
  INCLUDE_DIRS
  CATKIN_DEPENDS
    moveit_core
    moveit_visual_tools
    moveit_ros_planning_interface
    interactive_markers
    tf2_geometry_msgs
  DEPENDS
    EIGEN3
)

###########
## Build ##
###########


include_directories(
  ${catkin_INCLUDE_DIRS}
)



#############
## Install ##
#############



catkin_install_python(PROGRAMS
   scripts/ai_node
   scripts/cmd_state
   scripts/get_state
   scripts/cmd_state_machine
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

add_executable(move_interface nodes/move_interface.cpp)
target_link_libraries(move_interface ${catkin_LIBRARIES})
add_dependencies(move_interface ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
install(TARGETS move_interface DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})



#############
## Testing ##
#############


