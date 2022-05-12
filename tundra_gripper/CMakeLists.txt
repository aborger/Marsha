cmake_minimum_required(VERSION 3.0.2)

project(tundra_gripper)

find_package(catkin REQUIRED
	COMPONENTS
		roscpp
		std_msgs
		moveit_core
		moveit_ros_planning_interface
		marsha_msgs
)

catkin_package(
	CATKIN_DEPENDS
		moveit_core
		moveit_ros_planning_interface
		marsha_msgs
)

include_directories(
	include
	${catkin_INCLUDE_DIRS}
)

add_executable(grip_interface nodes/grip_interface.cpp)
target_link_libraries(grip_interface ${catkin_LIBRARIES})
add_dependencies(grip_interface marsha_msgs_generate_messages_cpp)