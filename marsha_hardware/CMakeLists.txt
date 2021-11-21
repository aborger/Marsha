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