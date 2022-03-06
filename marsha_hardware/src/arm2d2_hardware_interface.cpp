#include <marsha_hardware/arm2d2_hardware_interface.h>



MarshaArm::MarshaArm(ros::NodeHandle &nh_) {
    nh = nh_;
    //step_pub = nh.advertise<std_msgs::Int16MultiArray>("stepper_step", 10);
    j0_step_pub = nh.advertise<std_msgs::Int16>("/steppers/J0/cmd", 10);
    j1_step_pub = nh.advertise<std_msgs::Int16>("/steppers/J1/cmd", 10);
    j2_step_pub = nh.advertise<std_msgs::Int16>("/steppers/J2/cmd", 10);
    j3_step_pub = nh.advertise<std_msgs::Int16>("/steppers/J3/cmd", 10);
    j4_step_pub = nh.advertise<std_msgs::Int16>("/steppers/J4/cmd", 10);
    grip_pub = nh.advertise<std_msgs::Int16>("/steppers/grip/cmd", 10);
    //ros::Subscriber enc_sub = nh.subscribe("encoder_feedback", 100, &MarshaArm::encoderCallBack, this);

    // Note: This should be put in a loop for each controller

    for (int i = 0; i < NUM_JOINTS; i++) {
        ROS_INFO("Initiallizing joint: %s", joint_names[i].c_str());
        hardware_interface::JointStateHandle state_handle(joint_names[i], &pos[i], &vel[i], &eff[i]);
        joint_state_interface.registerHandle(state_handle);

        hardware_interface::JointHandle position_handle(state_handle, &cmd[i]);
        joint_position_interface.registerHandle(position_handle);

    }
    /*
    int grip_id = NUM_JOINTS - 1;
    ROS_INFO("gripper name: %s", joint_names[grip_id].c_str());
    hardware_interface::JointStateHandle gripper_state_handle(joint_names[grip_id], &pos[grip_id], &vel[grip_id], &eff[grip_id]);
    joint_state_interface.registerHandle(gripper_state_handle);
    hardware_interface::JointHandle gripper_effort_handle(gripper_state_handle, &cmd[grip_id]);
    joint_effort_interface.registerHandle(gripper_effort_handle);

    registerInterface(&joint_state_interface);
    registerInterface(&joint_position_interface);
    registerInterface(&gripper_effort_handle);
    */
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

    float deg_per_steps = 1.8;
    std_msgs::Int16 num_steps;
    num_steps.data = int(radToDeg(cmd[0]) / deg_per_steps);
    j0_step_pub.publish(num_steps);

    num_steps.data = int(radToDeg(cmd[1]) / deg_per_steps);
    j1_step_pub.publish(num_steps);

    num_steps.data = int(radToDeg(cmd[2]) / deg_per_steps);
    j2_step_pub.publish(num_steps);

    num_steps.data = int(radToDeg(cmd[3]) / deg_per_steps);
    j3_step_pub.publish(num_steps);

    num_steps.data = int(radToDeg(cmd[4]) / deg_per_steps);
    j4_step_pub.publish(num_steps);
    //grip_pub.publish(cmd[0]);


}

/*void MarshaArm::encoderCallBack(const std_msgs::Int16MultiArray &msg) {
    // msg.data contains number of steps
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for(int i = 0; i < NUM_JOINTS - 1; i++) {
        pos[i] = msg.data[i] * deg_per_steps[i];
    }
}*/

double MarshaArm::radToDeg(double rad) {
	return rad / M_PI * 180.0;
}

double MarshaArm::degToRad(double deg) {
    return deg / 180.0 * M_PI;
}

MarshaArm::~MarshaArm() {}