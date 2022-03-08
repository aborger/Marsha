#include <marsha_hardware/ar3_hardware_interface.h>



AR3Interface::AR3Interface(ros::NodeHandle &nh_) {
    nh = nh_;
    
    try {
        ros::param::get("stepper_config/num_joints", num_joints);
        ros::param::get("stepper_config/joint_names", joint_names);
        ros::param::get("stepper_config/deg_per_step", deg_per_steps);
    }
    catch (int e) {
        ROS_ERROR("Stepper Config Parameters Not Loaded!");
    }

    cmd.resize(num_joints);
    pos.resize(num_joints);
    vel.resize(num_joints);
    eff.resize(num_joints);

    step_pub = nh.advertise<marsha_msgs::TeensyMsg>("teensy_cmd", 10);
    diablo_step_pub = nh.advertise<std_msgs::Int16>("diablo_cmd", 10);

    ros::Subscriber enc_sub = nh.subscribe("enc_feedback", 100, &AR3Interface::encoderCallBack, this);
    ros::Subscriber diablo_enc_sub = nh.subscribe("diablo_feedback", 100, &AR3Interface::diabloCallBack, this);

    // Note: This should be put in a loop for each controller

    for (int i = 0; i < num_joints; i++) {
        ROS_INFO("Initiallizing joint: %s", joint_names[i].c_str());
        hardware_interface::JointStateHandle state_handle(joint_names[i], &pos[i], &vel[i], &eff[i]);
        joint_state_interface.registerHandle(state_handle);

        hardware_interface::JointHandle position_handle(state_handle, &cmd[i]);
        joint_position_interface.registerHandle(position_handle);

    }
    
    int grip_id = num_joints - 1;
    ROS_INFO("gripper name: %s", joint_names[grip_id].c_str());
    hardware_interface::JointStateHandle gripper_state_handle(joint_names[grip_id], &pos[grip_id], &vel[grip_id], &eff[grip_id]);
    joint_state_interface.registerHandle(gripper_state_handle);
    hardware_interface::JointHandle gripper_effort_handle(gripper_state_handle, &cmd[grip_id]);
    joint_effort_interface.registerHandle(gripper_effort_handle);

    registerInterface(&joint_state_interface);
    registerInterface(&joint_position_interface);
    registerInterface(&gripper_effort_handle);

    // Initialize values
    for (int i = 0; i < num_joints; i++) {
        cmd[i] = 0.0;
        pos[i] = 0.0;
        vel[i] = 0.0;
        eff[i] = 0.0;
    }



}

void AR3Interface::read() {

}

// This math could be performed with a matrices for efficiency
void AR3Interface::write() {

    ROS_DEBUG("Writing %f, %f, %f, %f, %f", cmd[0], cmd[1], cmd[2], cmd[3], cmd[4]);

    marsha_msgs::TeensyMsg msg;

    for(int i = 0; i < num_joints; i++) {
        short num_steps;
        num_steps = int(radToDeg(cmd[i]) / deg_per_steps[i]);
        ROS_INFO("CMD: %f steps: %i deg_p_steps: %f", cmd[i], num_steps, deg_per_steps[i]);

        if (i == 1) {
            std_msgs::Int16 step_msg;
            step_msg.data = num_steps;
            diablo_step_pub.publish(step_msg);
        }
        else {
            msg.steps.push_back(num_steps);
        }
        
    }


    step_pub.publish(msg);



    //grip_pub.publish(cmd[0]);


}

void AR3Interface::encoderCallBack(const marsha_msgs::TeensyMsg &msg) {

    for(int i = 0; i < num_joints; i++) {
        pos[i] = msg.steps[i] * deg_per_steps[i];
        vel[i] = 0.0;
        eff[i] = 0.0;
    }
}

void AR3Interface::diabloCallBack(const std_msgs::Int16 &msg) {
    pos[1] = msg.data * deg_per_steps[1];
}

/*void AR3Interface::encoderCallBack(const std_msgs::Int16MultiArray &msg) {
    // msg.data contains number of steps
    std::vector<float> deg_per_steps;
    ros::param::get("/ar3/stepper_config/deg_per_step", deg_per_steps);
    for(int i = 0; i < NUM_JOINTS - 1; i++) {
        pos[i] = msg.data[i] * deg_per_steps[i];
    }
}*/

double AR3Interface::radToDeg(double rad) {
	return rad / M_PI * 180.0;
}

double AR3Interface::degToRad(double deg) {
    return deg / 180.0 * M_PI;
}

AR3Interface::~AR3Interface() {}