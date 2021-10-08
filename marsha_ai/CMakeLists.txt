cmake_minimum_required(VERSION 3.0.2)
project(marsha_ai)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(catkin REQUIRED
  COMPONENTS
    message_generation
    roscpp
    rospy
    std_msgs
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
    #gazebo_grasp_plugin_ros
)


find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED system filesystem date_time thread)


add_message_files(
  FILES
  #Pos.msg
)

add_service_files(
  FILES
  GetAttachedState.srv
)

generate_messages(
   DEPENDENCIES
   std_msgs
   marsha_ai
 )

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
  ${THIS_PACKAGE_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIR} 
  ${EIGEN3_INCLUDE_DIRS}
)



#############
## Install ##
#############


add_executable(pick_place src/pick_place.cpp)
target_link_libraries(pick_place ${catkin_LIBRARIES})
add_dependencies(pick_place ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
install(TARGETS pick_place DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
