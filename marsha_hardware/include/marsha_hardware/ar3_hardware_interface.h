#ifndef AR3_HARDWARE_INTERFACE_H
#define AR3_HARDWARE_INTERFACE_H

// Note: The only change from arm2d2 interface and ar3 is the use of the
// diablo controller on joint 2

#include <ros/ros.h>
#include <hardware_interface/joint_state_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/robot_hw.h>
#include <string.h>

#include <std_msgs/Int16.h>
#include <marsha_msgs/TeensyMsg.h>


class AR3Interface : public hardware_interface::RobotHW 
{
    public:
        AR3Interface(ros::NodeHandle &nh_);
        ~AR3Interface();

        void read();
        void write();
        void update(const ros::TimerEvent &e);

        void encoderCallBack(const marsha_msgs::TeensyMsg &msg);
        //void graspCallBack(const std_msgs::Bool &msg);
    private:
        ros::NodeHandle nh;
        ros::Publisher step_pub;
        

        
        //ros::Subscriber grip_sub;


        hardware_interface::JointStateInterface joint_state_interface;
        hardware_interface::PositionJointInterface joint_position_interface;
        std::vector<double> cmd;

        std::vector<double> pos;
        std::vector<double> vel;
        std::vector<double> eff;

        
        int num_joints;

        std::vector<std::string> joint_names;
        std::vector<float> deg_per_steps;



        double radToDeg(double rad);
        double degToRad(double deg);
};

#endif