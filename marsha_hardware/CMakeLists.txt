cmake_minimum_required(VERSION 3.0.2)
project(marsha_hardware)

find_package(catkin REQUIRED
    COMPONENTS
        message_generation
        std_msgs
)

add_message_files(
    FILES
    StepControl.msg
)

generate_messages(
    DEPENDENCIES
    std_msgs
)

catkin_package()

catkin_install_python(
    PROGRAMS
    src/pub_step
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)