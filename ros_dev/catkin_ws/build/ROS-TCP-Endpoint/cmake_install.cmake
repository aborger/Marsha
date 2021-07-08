# Install script for directory: C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/borge/MARSHA/ros_dev/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  include("C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/safe_execute_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint/msg" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint/msg/RosUnityError.msg"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint/msg/RosUnitySrvMessage.msg"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint/msg/RosUnitySysCommand.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint/srv" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint/srv/RosUnityTopicList.srv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/installspace/ros_tcp_endpoint-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/include/ros_tcp_endpoint")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/roseus/ros/ros_tcp_endpoint")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/common-lisp/ros/ros_tcp_endpoint")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/gennodejs/ros/ros_tcp_endpoint")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "C:/opt/ros/melodic/x64/python.exe" -m compileall "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/lib/site-packages/ros_tcp_endpoint")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/site-packages" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/lib/site-packages/ros_tcp_endpoint" REGEX "/\\_\\_init\\_\\_\\.py$" EXCLUDE REGEX "/\\_\\_init\\_\\_\\.pyc$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/site-packages" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/lib/site-packages/ros_tcp_endpoint" FILES_MATCHING REGEX "c:/users/borge/marsha/ros_dev/catkin_ws/devel/lib/site-packages/ros_tcp_endpoint/.+/__init__.pyc?$")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/installspace/ros_tcp_endpoint.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/installspace/ros_tcp_endpoint-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint/cmake" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/installspace/ros_tcp_endpointConfig.cmake"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ROS-TCP-Endpoint/catkin_generated/installspace/ros_tcp_endpointConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_tcp_endpoint" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ROS-TCP-Endpoint/package.xml")
endif()

