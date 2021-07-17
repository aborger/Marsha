# Install script for directory: C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ros_tutorials/roscpp_tutorials

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/install")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials/srv" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ros_tutorials/roscpp_tutorials/srv/TwoInts.srv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ros_tutorials/roscpp_tutorials/catkin_generated/installspace/roscpp_tutorials-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/include/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/roseus/ros/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/common-lisp/ros/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/gennodejs/ros/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "C:/opt/ros/melodic/x64/python.exe" -m compileall "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/site-packages/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/site-packages" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/site-packages/roscpp_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ros_tutorials/roscpp_tutorials/catkin_generated/installspace/roscpp_tutorials.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ros_tutorials/roscpp_tutorials/catkin_generated/installspace/roscpp_tutorials-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials/cmake" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ros_tutorials/roscpp_tutorials/catkin_generated/installspace/roscpp_tutorialsConfig.cmake"
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/ros_tutorials/roscpp_tutorials/catkin_generated/installspace/roscpp_tutorialsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ros_tutorials/roscpp_tutorials/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/notify_connect.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/talker.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/babbler.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/add_two_ints_client.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/add_two_ints_server.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/add_two_ints_server_class.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/anonymous_listener.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_with_userdata.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_multiple.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_threaded_spin.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_async_spin.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_with_tracked_object.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_unreliable.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/listener_class.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/node_handle_namespaces.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/custom_callback_processing.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/timers.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/parameters.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/cached_parameters.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/roscpp_tutorials" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/roscpp_tutorials/time_api_sleep.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roscpp_tutorials/launch" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/ros_tutorials/roscpp_tutorials/launch/talker_listener.launch")
endif()

