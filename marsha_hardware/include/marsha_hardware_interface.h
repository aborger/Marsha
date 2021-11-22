#ifndef MARSHA_HARDWARE_INTERFACE_H
#define MARSHA_HARDWARE_INTERFACE_H

#include <ros/ros.h>
#include <hardware_interface/joint_state_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/robot_hw.h>

#include <std_msgs/Int32.h>

class MarshaArm : public hardware_interface::RobotHW 
{
    public:
        MarshaArm(ros::NodeHandle &nh_);
        ~MarshaArm();

        void read();
        void write();
    private:
        ros::NodeHandle nh;
        ros::Publisher step_pub_0;
        ros::Publisher step_pub_1;

        hardware_interface::JointStateInterface joint_state_interface;
        hardware_interface::PositionJointInterface joint_position_interface;
        double cmd[2];
        double pos[2];
        double vel[2];
        double eff[2];
};

#endif