# Install script for directory: C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/msg" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/msg/Floats.msg"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/msg/HeaderString.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/srv" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/srv/AddTwoInts.srv"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/srv/BadTwoInts.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/rospy_tutorials-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/include/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/roseus/ros/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/common-lisp/ros/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/share/gennodejs/ros/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "C:/opt/ros/melodic/x64/python.exe" -m compileall "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/lib/site-packages/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/site-packages" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/devel/lib/site-packages/rospy_tutorials")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/rospy_tutorials.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/rospy_tutorials-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/cmake" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/rospy_tutorialsConfig.cmake"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/rospy_tutorialsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener_exec_install_python/listener.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener.py_exec_install_python/listener.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/talker")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_talker_exec_install_python/talker.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/talker.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_talker.py_exec_install_python/talker.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/001_talker_listener" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/001_talker_listener/README"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/001_talker_listener/talker_listener.launch"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/002_headers" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/002_headers" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener_header.py_exec_install_python/listener_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/002_headers" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/talker_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/002_headers" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_talker_header.py_exec_install_python/talker_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/002_headers" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/002_headers/headers.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/003_listener_with_user_data" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener_with_user_data.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/003_listener_with_user_data" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener_with_user_data.py_exec_install_python/listener_with_user_data.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/003_listener_with_user_data" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/003_listener_with_user_data/listener_with_user_data.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/004_listener_subscribe_notify" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener_subscribe_notify.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/004_listener_subscribe_notify" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener_subscribe_notify.py_exec_install_python/listener_subscribe_notify.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/004_listener_subscribe_notify" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/004_listener_subscribe_notify/listener_subscribe_notify.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/005_add_two_ints" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/add_two_ints_client")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/005_add_two_ints" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_add_two_ints_client_exec_install_python/add_two_ints_client.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/005_add_two_ints" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/add_two_ints_server")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/005_add_two_ints" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_add_two_ints_server_exec_install_python/add_two_ints_server.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/006_parameters" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/param_talker.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/006_parameters" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_param_talker.py_exec_install_python/param_talker.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/006_parameters" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/006_parameters/param_talker.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/client_connection_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_client_connection_header.py_exec_install_python/client_connection_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/listener_connection_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_listener_connection_header.py_exec_install_python/listener_connection_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/server_connection_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_server_connection_header.py_exec_install_python/server_connection_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/talker_connection_header.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_talker_connection_header.py_exec_install_python/talker_connection_header.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/007_connection_header" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/007_connection_header/connection_header.launch"
    "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/007_connection_header/README"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/008_on_shutdown" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/publish_on_shutdown.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/008_on_shutdown" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_publish_on_shutdown.py_exec_install_python/publish_on_shutdown.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/008_on_shutdown" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/008_on_shutdown/on_shutdown.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/009_advanced_publish" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/advanced_publish.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/009_advanced_publish" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_advanced_publish.py_exec_install_python/advanced_publish.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/009_advanced_publish" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/009_advanced_publish/advanced_publish.launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/010_publish_pointcloud2" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/installspace/publish_pointcloud2.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/010_publish_pointcloud2" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/build/ros_tutorials/rospy_tutorials/catkin_generated/windows_wrappers/rospy_tutorials_publish_pointcloud2.py_exec_install_python/publish_pointcloud2.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rospy_tutorials/010_publish_pointcloud2" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/catkin_ws/src/ros_tutorials/rospy_tutorials/010_publish_pointcloud2/publish_pointcloud2.launch")
endif()

