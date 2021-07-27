cmake_minimum_required(VERSION 3.0.2)
project(marsha)


find_package(catkin REQUIRED 
  COMPONENTS
    message_generation
    roscpp
    rospy
    std_msgs
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
)

find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED system filesystem date_time thread)
find_package(OpenCV)

add_message_files(
   FILES
   Floats.msg
   TrainData.msg
   Log.msg
   TrainInfo.msg
)

generate_messages(
   DEPENDENCIES
   std_msgs
   marsha
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
  ${catkin_INCLUDE_DIRS} 
  ${Boost_INCLUDE_DIR} 
  ${EIGEN3_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)

catkin_install_python(PROGRAMS
 DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)


add_executable(move src/move_group.cpp)
target_link_libraries(move ${catkin_LIBRARIES} ${Boost_LIBRARIES})
install(TARGETS move DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})



install(DIRECTORY launch DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})


