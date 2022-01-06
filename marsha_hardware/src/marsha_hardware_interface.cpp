#include "marsha_hardware_interface.hpp"
#include <std_msgs/MultiArrayDimension.h>
#include <std_msgs/Bool.h>



MarshaArm::MarshaArm(ros::NodeHandle &nh_) {
    nh = nh_;

    step_pub = nh.advertise<std_msgs::Int32MultiArray>("stepper_step", 10);
    ros::Subscriber enc_sub = nh.subscribe("encoder_feedback", 100, &MarshaArm::encoderCallBack, this);

    // Note: This should be put in a loop for each controller

    for (int i = 0; i < NUM_JOINTS - 1; i++) {
        hardware_interface::JointStateHandle state_handle(joint_names[i], &pos[i], &vel[i], &eff[i]);
        joint_state_interface.registerHandle(state_handle);

        hardware_interface::JointHandle position_handle(state_handle, &cmd[i]);
        joint_position_interface.registerHandle(position_handle);

    }

    int grip_id = NUM_JOINTS - 1;
    hardware_interface::JointStateHandle gripper_state_handle(joint_names[grip_id], &pos[grip_id], &vel[grip_id], &eff[grip_id]);
    joint_state_interface.registerHandle(gripper_state_handle);
    hardware_interface::JointHandle gripper_effort_handle(gripper_state_handle, &cmd[grip_id]);
    joint_effort_interface.registerHandle(gripper_effort_handle);

    registerInterface(&joint_state_interface);
    registerInterface(&joint_position_interface);
    registerInterface(&gripper_effort_handle);

    //rostopic pub stepper_step std_msgs/Int32MultiArray '{layout: {data_offset: 69420, dim: [{stride: 25}]}, data: [0, 0, 0, 0, 0, 0]}'    std_msgs::Float64MultiArray arr;
    int step_delay;
    std_msgs::Int32MultiArray arr;
    ros::param::get("ar3/stepper_config/step_delay", step_delay);
    arr.layout.data_offset = 69420; // Header key that indicates this message is the configuration header
    std_msgs::MultiArrayDimension dim;
    dim.stride = step_delay;
    arr.layout.dim.push_back(dim);
    step_pub.publish(arr);

    // Initialize output values
    for (int i = 0; i < NUM_JOINTS; i++) {
        pos[i] = 0.0;
        vel[i] = 0.0;
        eff[i] = 0.0;
    }


}

void MarshaArm::read() {
    // Read encoders currently done in encoderCallBack
    //for(int i = 0; i < 6; i++) {

    //}
}

void MarshaArm::write() {
    std_msgs::Int32MultiArray array; // can probably use Int32
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for (int i = 0; i < NUM_JOINTS - 1; i++) {
        int num_steps = int(radToDeg(cmd[i]) / deg_per_steps[i]); // deg/step for j1
        array.data.push_back(num_steps);
    }
    step_pub.publish(array);
}

void MarshaArm::encoderCallBack(const std_msgs::Int32MultiArray &msg) {
    // msg.data contains number of steps
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for(int i = 0; i < NUM_JOINTS - 1; i++) {
        pos[i] = msg.data[i] * deg_per_steps[i];
    }
}

double MarshaArm::radToDeg(double rad) {
	return rad / M_PI * 180.0;
}

double MarshaArm::degToRad(double deg) {
    return deg / 180.0 * M_PI;
}

MarshaArm::~MarshaArm() {}