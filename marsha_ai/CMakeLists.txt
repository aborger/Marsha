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
    #rosbridge_server
    pluginlib
    geometric_shapes
    pcl_ros
    pcl_conversions
    rosbag
    tf2_ros
    tf2_eigen
    tf2_geometry_msgs
    marsha_msgs
    #rospy_message_converter
    #ros_numpy
)



catkin_python_setup()



include_directories(include)
 
generate_messages(
  DEPENDENCIES
    std_msgs
    marsha_msgs
)

catkin_package(
  CATKIN_DEPENDS
    tf2_geometry_msgs
    rospy
    roscpp
    marsha_msgs
  DEPENDS
    EIGEN3
)



include_directories(
  ${catkin_INCLUDE_DIRS}
)





catkin_install_python(
  PROGRAMS
   nodes/ai_node
   nodes/mdp_ai_node
   nodes/spawn_tensorboard
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

catkin_install_python(
    PROGRAMS
      tests/test_move_interface
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

add_executable(grasp_generator nodes/grasp_generator.cpp)
target_link_libraries(grasp_generator ${catkin_LIBRARIES})
#add_dependencies(grasp_generator marsha_msgs)

add_executable(trajectory_predictor nodes/trajectory_predictor.cpp)
target_link_libraries(trajectory_predictor ${catkin_LIBRARIES})
#add_dependencies(trajectory_predictor marsha_msgs)


