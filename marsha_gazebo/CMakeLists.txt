cmake_minimum_required(VERSION 2.8.3)
project(marsha_gazebo)

find_package(catkin REQUIRED
    COMPONENTS
        message_generation
        roscpp
        std_msgs
        gazebo_msgs
        marsha_msgs
)

catkin_python_setup()

catkin_package(
    LIBRARIES
    INCLUDE_DIRS
    CATKIN_DEPENDS
)

include_directories(
    ${catkin_INCLUDE_DIRS}
)


install(PROGRAMS
    src/tf_world_transform.py
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

catkin_install_python(PROGRAMS
    nodes/reset
    nodes/object_location
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

add_executable(grasped_state_server nodes/grasped_state_server.cpp)
target_link_libraries(grasped_state_server ${catkin_LIBRARIES})
add_dependencies(grasped_state_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
install(TARGETS grasped_state_server DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})