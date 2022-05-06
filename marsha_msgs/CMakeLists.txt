cmake_minimum_required(VERSION 3.0.2) 
project(marsha_msgs)

find_package(catkin REQUIRED
    COMPONENTS
        message_generation
        std_msgs
        geometry_msgs
        genmsg
        actionlib_msgs
)

add_message_files(
    FILES
    Timer.msg
    Polar.msg 
    TeensyMsg.msg
    ObjectEstimate.msg
)
  
add_service_files(
    FILES
    GraspedState.srv
    MoveCmd.srv
    GetPos.srv
    GetPosFrame.srv
    PayloadCmd.srv
    PositionCmd.srv
    PlanGrasp.srv
    Reset.srv
    StateComm.srv
    GenerateGrasp.srv
    PostureCmd.srv
    GetFrame.srv  
    GetDepth.srv 
    JointCmd.srv
    PredictPosition.srv
    ObjectObservation.srv
)

add_action_files(
    DIRECTORY action
    FILES
    PositionCmd.action
)

generate_messages(
    DEPENDENCIES
    std_msgs
    geometry_msgs
    actionlib_msgs
)

catkin_package(
    
)