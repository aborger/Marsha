#include "marsha_hardware_interface.hpp"

MarshaArm::MarshaArm(ros::NodeHandle &nh_) {
    nh = nh_;

    step_pub_0 = nh.advertise<std_msgs::Float64>("stepper_step0", 10);
    step_pub_1 = nh.advertise<std_msgs::Float64>("stepper_step1", 10);

    // Note: This should be put in a loop for each controller

    for (int i = 0; i < 6; i++) {
        hardware_interface::JointStateHandle state_handle(joint_names[i], &pos[i], &vel[i], &eff[i]);
        joint_state_interface.registerHandle(state_handle);

        hardware_interface::JointHandle position_handle(state_handle, &cmd[i]);
        joint_position_interface.registerHandle(position_handle);

    }

    registerInterface(&joint_state_interface);
    registerInterface(&joint_position_interface);


}

void MarshaArm::read() {
    pos[0] = cmd[0];
    pos[1] = cmd[1];
}

void MarshaArm::write() {
    std_msgs::Float64 step0_msg;
    std_msgs::Float64 step1_msg;
    step0_msg.data = cmd[0];
    step1_msg.data = cmd[1];
    step_pub_0.publish(step0_msg);
    step_pub_1.publish(step1_msg);
}

MarshaArm::~MarshaArm() {}