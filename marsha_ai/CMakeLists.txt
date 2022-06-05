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

catkin_package(
  INCLUDE_DIRS
    include
  LIBRARIES
    ${PROJECT_NAME}
  CATKIN_DEPENDS
    tf2_geometry_msgs
    rospy
    roscpp
    marsha_msgs
    geometry_msgs
)



include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)





catkin_install_python(
  PROGRAMS
   nodes/ai_node
   nodes/ai_pcs
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
add_dependencies(grasp_generator marsha_msgs_generate_messages_cpp)


add_executable(trajectory_predictor nodes/trajectory_predictor.cpp)
target_link_libraries(trajectory_predictor ${catkin_LIBRARIES})
add_dependencies(trajectory_predictor marsha_msgs_generate_messages_cpp)

add_executable(trajectory_predictor_kalman nodes/trajectory_predictor_kalman.cpp)
target_link_libraries(trajectory_predictor_kalman ${catkin_LIBRARIES})
add_dependencies(trajectory_predictor_kalman marsha_msgs_generate_messages_cpp)

# Im pretty sure catkin provides a better method for test programs, but im using the test as a normal executable for now
add_executable(test_object_dynamics tests/test_object_dynamics.cpp)
target_link_libraries(test_object_dynamics ${catkin_LIBRARIES})
add_dependencies(test_object_dynamics marsha_msgs_generate_messages_cpp)