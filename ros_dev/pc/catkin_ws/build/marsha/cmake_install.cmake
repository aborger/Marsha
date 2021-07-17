# Install script for directory: C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/marsha

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/marsha/msg" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/marsha/msg/Floats.msg"
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/marsha/msg/TrainData.msg"
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/marsha/msg/Log.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/marsha/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/marsha-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/include/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/roseus/ros/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/common-lisp/ros/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/gennodejs/ros/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "C:/opt/ros/melodic/x64/python.exe" -m compileall "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/site-packages/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/site-packages" TYPE DIRECTORY FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/lib/site-packages/marsha")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/marsha.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/marsha/cmake" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/marsha-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/marsha/cmake" TYPE FILE FILES
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/marshaConfig.cmake"
    "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/marshaConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/marsha" TYPE FILE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/marsha/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/marsha" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/nn_trainer.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/marsha" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/windows_wrappers/marsha_nn_trainer.py_exec_install_python/nn_trainer.exe")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/marsha" TYPE PROGRAM FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/installspace/random_generator.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/marsha" TYPE EXECUTABLE FILES "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/build/marsha/catkin_generated/windows_wrappers/marsha_random_generator.py_exec_install_python/random_generator.exe")
endif()

