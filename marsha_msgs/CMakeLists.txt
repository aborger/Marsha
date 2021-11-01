cmake_minimum_required(VERSION 3.0.2)
project(marsha_msgs)

find_package(catkin REQUIRED
    COMPONENTS
        message_generation
        std_msgs
        geometry_msgs
)

add_service_files(
    FILES
    GetPose.srv
)

generate_messages(
    DEPENDENCIES
    std_msgs
    geometry_msgs
)

catkin_package(
    
)