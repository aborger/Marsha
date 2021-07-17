# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "franka_msgs: 9 messages, 7 services")

set(MSG_I_FLAGS "-Ifranka_msgs:C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg;-Ifranka_msgs:C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg;-Istd_msgs:C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg;-Iactionlib_msgs:C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(franka_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" "actionlib_msgs/GoalID:std_msgs/Header:actionlib_msgs/GoalStatus:franka_msgs/ErrorRecoveryFeedback:franka_msgs/ErrorRecoveryActionGoal:franka_msgs/ErrorRecoveryActionResult:franka_msgs/ErrorRecoveryResult:franka_msgs/ErrorRecoveryActionFeedback:franka_msgs/ErrorRecoveryGoal"
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" "std_msgs/Header:franka_msgs/Errors"
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" "std_msgs/Header:actionlib_msgs/GoalID:franka_msgs/ErrorRecoveryGoal"
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" "std_msgs/Header:franka_msgs/ErrorRecoveryResult:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" "std_msgs/Header:franka_msgs/ErrorRecoveryFeedback:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" ""
)

get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_custom_target(_franka_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "franka_msgs" "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_msg_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)

### Generating Services
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)
_generate_srv_cpp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
)

### Generating Module File
_generate_module_cpp(franka_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(franka_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(franka_msgs_generate_messages franka_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_cpp _franka_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(franka_msgs_gencpp)
add_dependencies(franka_msgs_gencpp franka_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS franka_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_msg_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)

### Generating Services
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)
_generate_srv_eus(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
)

### Generating Module File
_generate_module_eus(franka_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(franka_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(franka_msgs_generate_messages franka_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_eus _franka_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(franka_msgs_geneus)
add_dependencies(franka_msgs_geneus franka_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS franka_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_msg_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)

### Generating Services
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)
_generate_srv_lisp(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
)

### Generating Module File
_generate_module_lisp(franka_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(franka_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(franka_msgs_generate_messages franka_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_lisp _franka_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(franka_msgs_genlisp)
add_dependencies(franka_msgs_genlisp franka_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS franka_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_msg_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)

### Generating Services
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)
_generate_srv_nodejs(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
)

### Generating Module File
_generate_module_nodejs(franka_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(franka_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(franka_msgs_generate_messages franka_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_nodejs _franka_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(franka_msgs_gennodejs)
add_dependencies(franka_msgs_gennodejs franka_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS franka_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_msg_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "C:/opt/ros/melodic/x64/share/std_msgs/cmake/../msg/Header.msg;C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalID.msg;C:/opt/ros/melodic/x64/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)

### Generating Services
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)
_generate_srv_py(franka_msgs
  "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
)

### Generating Module File
_generate_module_py(franka_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(franka_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(franka_msgs_generate_messages franka_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetLoad.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/Errors.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryAction.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetFullCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/msg/FrankaState.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionGoal.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetJointImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionResult.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetKFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetCartesianImpedance.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/devel/share/franka_msgs/msg/ErrorRecoveryActionFeedback.msg" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetEEFrame.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "C:/Users/borge/MARSHA/ros_dev/pc/catkin_ws/src/franka_ros/franka_msgs/srv/SetForceTorqueCollisionBehavior.srv" NAME_WE)
add_dependencies(franka_msgs_generate_messages_py _franka_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(franka_msgs_genpy)
add_dependencies(franka_msgs_genpy franka_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS franka_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/franka_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(franka_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(franka_msgs_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/franka_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(franka_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(franka_msgs_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/franka_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(franka_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(franka_msgs_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/franka_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(franka_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(franka_msgs_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs)
  install(CODE "execute_process(COMMAND \"C:/opt/ros/melodic/x64/python.exe\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/franka_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(franka_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(franka_msgs_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
