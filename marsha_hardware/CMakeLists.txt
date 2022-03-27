# TODO: move ar3 and arm2d2 hardware interface .cpp files to the include dir and change them to a .h file

cmake_minimum_required(VERSION 3.0.2)
project(marsha_hardware)

find_package(catkin REQUIRED
    COMPONENTS
        roscpp
        message_generation
        std_msgs
        hardware_interface
        controller_manager
        control_msgs
)

# Boost
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})





add_message_files(
    FILES
    StepControl.msg
)

catkin_python_setup()

generate_messages(
    DEPENDENCIES
    std_msgs
)



catkin_package(
    INCLUDE_DIRS
        include
    LIBRARIES
        ${PROJECT_NAME}
    CATKIN_DEPENDS
        hardware_interface
        controller_manager
        roscpp
        control_msgs
    DEPENDS
        Boost
)

include_directories(
    include
    ${catkin_INCLUDE_DIRS}
)

add_library(ar3_hardware_interface src/ar3_hardware_interface.cpp)
add_dependencies(ar3_hardware_interface ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(ar3_hardware_interface ${catkin_LIBRARIES})

add_library(arm2d2_hardware_interface src/arm2d2_hardware_interface.cpp)
add_dependencies(arm2d2_hardware_interface ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(arm2d2_hardware_interface ${catkin_LIBRARIES})

catkin_install_python(
    PROGRAMS
    scripts/pub_step
    scripts/serial_test
    scripts/teensy_interface
    nodes/diablo_controller
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)




add_executable(marsha_hardware_interface_node nodes/marsha_hardware_interface_node.cpp)
target_link_libraries(marsha_hardware_interface_node arm2d2_hardware_interface ar3_hardware_interface ${catkin_LIBRARIES})


