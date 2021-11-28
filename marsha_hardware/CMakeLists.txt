cmake_minimum_required(VERSION 3.0.2)
project(marsha_hardware)

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

catkin_python_setup()

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

catkin_install_python(
    PROGRAMS
    scripts/pub_step
    nodes/diablo_controller
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

#add_library(marsha_hardware_driver src/marsha_hardware_driver.cpp)
#target_link_libraries(marsha_hardware_driver ${catkin_LIBRARIES} ${Boost_LIBRARIES})


add_library(marsha_hardware_interface src/marsha_hardware_interface.cpp)
target_link_libraries(marsha_hardware_interface ${catkin_LIBRARIES})

#add_executable(hardware_driver src/marsha_hardware_driver.cpp)
add_executable(marsha_hardware_interface_node nodes/marsha_hardware_interface_node.cpp)

#target_link_libraries(hardware_driver
#    ${catkin_LIBRARIES}
#    ${Boost_LIBRARIES}
#)

target_link_libraries(marsha_hardware_interface_node 
    marsha_hardware_interface
    #marsha_hardware_driver
    ${catkin_LIBRARIES}
)


add_dependencies(marsha_hardware_interface_node 
    marsha_hardware_interface
    #marsha_hardware_driver
    ${${PROJECT_NAME}_EXPORTED_TARGETS} 
    ${catkin_EXPORTED_TARGETS}
)