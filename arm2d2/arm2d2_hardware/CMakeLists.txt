cmake_minimum_required(VERSION 3.0.2)
project(arm2d2_hardware)

find_package(catkin REQUIRED
    COMPONENTS
        roscpp
        message_generation
        std_msgs
        hardware_interface
        controller_manager
)

# Boost
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})

add_message_files(
    FILES
    StepControl.msg
)



generate_messages(
    DEPENDENCIES
    std_msgs
)

catkin_package(
    INCLUDE_DIRS
        include
    LIBRARIES
        marsha_hardware_interface
        marsha_hardware_driver
    CATKIN_DEPENDS
        hardware_interface
        controller_manager
        roscpp
        control_msgs
    DEPENDS
        Boost
)

include_directories(
    include/
    ${catkin_INCLUDE_DIRS}
)

add_library(arm2d2_hardware_interface src/arm2d2_hardware_interface.cpp)
target_link_libraries(arm2d2_hardware_interface ${catkin_LIBRARIES})