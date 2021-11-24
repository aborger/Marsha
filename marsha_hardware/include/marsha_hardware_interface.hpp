#ifndef MARSHA_HARDWARE_INTERFACE_H
#define MARSHA_HARDWARE_INTERFACE_H

#include <ros/ros.h>
#include <hardware_interface/joint_state_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/robot_hw.h>
#include <string.h>

#include <std_msgs/Int32MultiArray.h>

class MarshaArm : public hardware_interface::RobotHW 
{
    public:
        MarshaArm(ros::NodeHandle &nh_);
        ~MarshaArm();

        void read();
        void write();
        void encoderCallBack(const std_msgs::Int32MultiArray &msg);
    private:
        ros::NodeHandle nh;
        ros::Publisher step_pub;

        hardware_interface::JointStateInterface joint_state_interface;
        hardware_interface::PositionJointInterface joint_position_interface;
        double cmd[6];

        double pos[6];
        double vel[6];
        double eff[6];


        std::string joint_names[6] = {
            "joint_1",
            "joint_2",
            "joint_3",
            "joint_4",
            "joint_5",
            "joint_6"
        };

        double radToDeg(double rad);
        double degToRad(double deg);
};

#endif