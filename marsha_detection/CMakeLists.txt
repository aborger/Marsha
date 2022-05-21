cmake_minimum_required(VERSION 3.0.2)
project(marsha_detection)

find_package(catkin REQUIRED
    COMPONENTS
        rospy
        std_msgs
)

find_package(OpenCV REQUIRED)

catkin_python_setup()

include_directories(include)

catkin_package(
    CATKIN_DEPENDS
        rospy 
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

catkin_install_python(
    PROGRAMS
        nodes/locate
        nodes/record
        nodes/record_longeron
        nodes/detect_object
        scripts/train
        scripts/view 
        scripts/smoother
    DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)