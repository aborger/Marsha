execute_process(COMMAND "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/python_distutils_install.bat" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/python_distutils_install.bat) returned error code ")
endif()
