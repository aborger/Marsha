cmake_minimum_required(VERSION 3.0.2)
project(marsha_ai)


find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  message_generation
)




## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################



################################################
## Declare ROS dynamic reconfigure parameters ##
################################################



###################################
## catkin specific configuration ##
###################################

add_message_files(
  FILES
  Pos.msg
)

generate_messages(
   DEPENDENCIES
   std_msgs
   marsha_ai
 )

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES marsha_ai
#  CATKIN_DEPENDS rospy std_msgs
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

## Declare a C++ library
# add_library(${PROJECT_NAME}
#   src/${PROJECT_NAME}/marsha_ai.cpp
# )

# add_dependencies(${PROJECT_NAME}_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Specify libraries to link a library or executable target against
# target_link_libraries(${PROJECT_NAME}_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############



catkin_install_python(PROGRAMS
   scripts/ai_node
   scripts/move_interface
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)



#############
## Testing ##
#############


