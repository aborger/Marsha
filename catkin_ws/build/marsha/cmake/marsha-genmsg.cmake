# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "marsha: 4 messages, 0 services")

set(MSG_I_FLAGS "-Imarsha:/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Imarsha:/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(marsha_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_custom_target(_marsha_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "marsha" "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" ""
)

get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_custom_target(_marsha_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "marsha" "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" ""
)

get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_custom_target(_marsha_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "marsha" "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" ""
)

get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_custom_target(_marsha_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "marsha" "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
)
_generate_msg_cpp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
)
_generate_msg_cpp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
)
_generate_msg_cpp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
)

### Generating Services

### Generating Module File
_generate_module_cpp(marsha
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(marsha_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(marsha_generate_messages marsha_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_dependencies(marsha_generate_messages_cpp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_dependencies(marsha_generate_messages_cpp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_dependencies(marsha_generate_messages_cpp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_dependencies(marsha_generate_messages_cpp _marsha_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(marsha_gencpp)
add_dependencies(marsha_gencpp marsha_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS marsha_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
)
_generate_msg_eus(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
)
_generate_msg_eus(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
)
_generate_msg_eus(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
)

### Generating Services

### Generating Module File
_generate_module_eus(marsha
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(marsha_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(marsha_generate_messages marsha_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_dependencies(marsha_generate_messages_eus _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_dependencies(marsha_generate_messages_eus _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_dependencies(marsha_generate_messages_eus _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_dependencies(marsha_generate_messages_eus _marsha_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(marsha_geneus)
add_dependencies(marsha_geneus marsha_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS marsha_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
)
_generate_msg_lisp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
)
_generate_msg_lisp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
)
_generate_msg_lisp(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
)

### Generating Services

### Generating Module File
_generate_module_lisp(marsha
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(marsha_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(marsha_generate_messages marsha_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_dependencies(marsha_generate_messages_lisp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_dependencies(marsha_generate_messages_lisp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_dependencies(marsha_generate_messages_lisp _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_dependencies(marsha_generate_messages_lisp _marsha_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(marsha_genlisp)
add_dependencies(marsha_genlisp marsha_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS marsha_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
)
_generate_msg_nodejs(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
)
_generate_msg_nodejs(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
)
_generate_msg_nodejs(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
)

### Generating Services

### Generating Module File
_generate_module_nodejs(marsha
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(marsha_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(marsha_generate_messages marsha_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_dependencies(marsha_generate_messages_nodejs _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_dependencies(marsha_generate_messages_nodejs _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_dependencies(marsha_generate_messages_nodejs _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_dependencies(marsha_generate_messages_nodejs _marsha_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(marsha_gennodejs)
add_dependencies(marsha_gennodejs marsha_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS marsha_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
)
_generate_msg_py(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
)
_generate_msg_py(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
)
_generate_msg_py(marsha
  "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
)

### Generating Services

### Generating Module File
_generate_module_py(marsha
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(marsha_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(marsha_generate_messages marsha_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainData.msg" NAME_WE)
add_dependencies(marsha_generate_messages_py _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Log.msg" NAME_WE)
add_dependencies(marsha_generate_messages_py _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/Floats.msg" NAME_WE)
add_dependencies(marsha_generate_messages_py _marsha_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/aaron/MARSHA/ros_dev/nano/catkin_ws/src/marsha/msg/TrainInfo.msg" NAME_WE)
add_dependencies(marsha_generate_messages_py _marsha_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(marsha_genpy)
add_dependencies(marsha_genpy marsha_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS marsha_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/marsha
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(marsha_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET marsha_generate_messages_cpp)
  add_dependencies(marsha_generate_messages_cpp marsha_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/marsha
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(marsha_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET marsha_generate_messages_eus)
  add_dependencies(marsha_generate_messages_eus marsha_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/marsha
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(marsha_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET marsha_generate_messages_lisp)
  add_dependencies(marsha_generate_messages_lisp marsha_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/marsha
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(marsha_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET marsha_generate_messages_nodejs)
  add_dependencies(marsha_generate_messages_nodejs marsha_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/marsha
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(marsha_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET marsha_generate_messages_py)
  add_dependencies(marsha_generate_messages_py marsha_generate_messages_py)
endif()
