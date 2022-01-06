/*
* Creates two services pos_cmd and grasp_cmd

* These services take a string as input which corresponds to a pose param file

* The service then performs the pose

* Author: Aaron Borger <borger.aaron@gmail.com>

*/


#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>


#include <ros/ros.h>
#include "marsha_msgs/MoveCmd.h"

#include <string>


#include <vector>


static const std::string GRIPPER_PLANNING_GROUP = "gripper";

class MarshaMoveInterface {
    private:
        moveit::planning_interface::MoveGroupInterface* hand_group;

        
        ros::ServiceServer graspService;

        std::string pose_param;
 

        bool graspCmd(marsha_msgs::MoveCmd::Request &req,
                    marsha_msgs::MoveCmd::Response &res)
        {

            ROS_INFO("Gripping pose: %s", req.pose_name.c_str());
            std::string param = "/gripper/" + req.pose_name;
            std::vector<double> joint_targets(3);

            if (!ros::param::get(param, joint_targets[0])) {
                res.done = false;
                return false;
            }
            ros::param::get(param, joint_targets[1]);
            ros::param::get(param, joint_targets[2]);

            hand_group->setJointValueTarget(joint_targets);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (hand_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");
            hand_group->execute(target_plan);

            res.done = success;
            return true;
        }


    public:
        MarshaMoveInterface(ros::NodeHandle *nh) {
            hand_group = new moveit::planning_interface::MoveGroupInterface(GRIPPER_PLANNING_GROUP);

            graspService = nh->advertiseService("grasp_cmd", &MarshaMoveInterface::graspCmd, this);

        }

};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "move_interface");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();
    MarshaMoveInterface interface = MarshaMoveInterface(&nh);
    ros::waitForShutdown();
}