cmake_minimum_required(VERSION 2.8.3)

project(tundra_gripper)

find_package(catkin REQUIRED)

catkin_package()

find_package(roslaunch)

#add_executable(grip_interface nodes/grip_interface.cpp)
#target_link_libraries(grip_interface ${catkin_LIBRARIES})
#add_dependencies(grip_interface marsha_msgs_generate_messages_cpp)
foreach(dir config launch meshes urdf)
	install(DIRECTORY ${dir}/
		DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/${dir})
endforeach(dir)
