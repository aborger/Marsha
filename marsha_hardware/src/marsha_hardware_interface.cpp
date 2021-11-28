#include "marsha_hardware_interface.hpp"
#include <std_msgs/MultiArrayDimension.h>

#define NUM_JOINTS 6

MarshaArm::MarshaArm(ros::NodeHandle &nh_) {
    nh = nh_;

    step_pub = nh.advertise<std_msgs::Int16MultiArray>("stepper_step", 10);
    ros::Subscriber sub = nh.subscribe("encoder_feedback", 100, &MarshaArm::encoderCallBack, this);

    // Note: This should be put in a loop for each controller

    for (int i = 0; i < NUM_JOINTS; i++) {
        hardware_interface::JointStateHandle state_handle(joint_names[i], &pos[i], &vel[i], &eff[i]);
        joint_state_interface.registerHandle(state_handle);

        hardware_interface::JointHandle position_handle(state_handle, &cmd[i]);
        joint_position_interface.registerHandle(position_handle);

    }

    registerInterface(&joint_state_interface);
    registerInterface(&joint_position_interface);

    //rostopic pub stepper_step std_msgs/Int16MultiArray '{layout: {data_offset: 69420, dim: [{stride: 25}]}, data: [0, 0, 0, 0, 0, 0]}'    std_msgs::Float64MultiArray arr;
    int step_delay;
    std_msgs::Int16MultiArray arr;
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
    std_msgs::Int16MultiArray array; // can probably use Int16
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for (int i = 0; i < NUM_JOINTS; i++) {
        long int num_steps = int(radToDeg(cmd[i]) / deg_per_steps[i]); // deg/step for j1
        array.data.push_back(num_steps);
    }
    step_pub.publish(array);
}

void MarshaArm::encoderCallBack(const std_msgs::Int16MultiArray &msg) {
    // msg.data contains number of steps
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for(int i = 0; i < NUM_JOINTS; i++) {
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