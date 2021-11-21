#include "marsha_hardware_interface.h"

MarshaArm::MarshaArm(ros::NodeHandle &nh_) {
    nh = nh_;

    step_pub_0 = nh.advertise<std_msgs::Int32>("stepper_step0", 10);
    step_pub_1 = nh.advertise<std_msgs::Int32>("stepper_step1", 10);

    // Note: This should be put in a loop for each controller

    // Connect joint state interface
    hardware_interface::JointStateHandle state_handle_0("state_0", &pos[0], &vel[0], &eff[0]);
    joint_state_interface.registerHandle(state_handle_0);

    hardware_interface::JointStateHandle state_handle_1("state_1", &pos[1], &vel[1], &eff[1]);
    joint_state_interface.registerHandle(state_handle_1);

    registerInterface(&joint_state_interface);

    // Connect joint position interface
    hardware_interface::JointHandle pos_handle_0(joint_state_interface.getHandle("state_0"), &cmd[0]);
    joint_position_interface.registerHandle(pos_handle_0);

    hardware_interface::JointHandle pos_handle_1(joint_state_interface.getHandle("state_1"), &cmd[1]);
    joint_position_interface.registerHandle(pos_handle_1);

    registerInterface(&joint_position_interface);
}

void MarshaArm::read() {
    pos[0] = cmd[0];
    pos[1] = cmd[1];
}

void MarshaArm::write() {
    std_msgs::Int32 step0_msg;
    std_msgs::Int32 step1_msg;
    step0_msg.data = (int)cmd[0];
    step1_msg.data = (int)cmd[1];
    step_pub_0.publish(step0_msg);
    step_pub_1.publish(step1_msg);
}

MarshaArm::~MarshaArm() {}