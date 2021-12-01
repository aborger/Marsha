/*
* Creates two services pos_cmd and grasp_cmd

* These services take a string as input which corresponds to a pose param file

* The service then performs the pose

* Author: Aaron Borger <borger.aaron@gmail.com>

*/

// THIS NEEDS TO BE MOVED OUT OF AI PACKAGE


#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>

#include <ros/ros.h>
#include "geometry_msgs/Pose.h" // Replace with geometry_msgs/Pose.msg
#include "marsha_msgs/MoveCmd.h"
#include "marsha_msgs/PositionCmd.h"
#include "marsha_msgs/GetPos.h"

#include <std_msgs/Empty.h>
#include <string>

#include <geometry_msgs/Pose.h>


#include <vector>

static const std::string ARM_PLANNING_GROUP = "manipulator";
static const std::string GRIPPER_PLANNING_GROUP = "gripper";

class MarshaMoveInterface {
    private:
        moveit::planning_interface::MoveGroupInterface* move_group;
        moveit::planning_interface::MoveGroupInterface* hand_group;

        
        ros::ServiceServer poseService;
        ros::ServiceServer positionService;
        ros::ServiceServer graspService;
        ros::ServiceServer getPosService;
        //ros::Subscriber position_sub;
        ros::Subscriber get_pose_sub;

        std::string pose_param;


        bool poseCmd(marsha_msgs::MoveCmd::Request &req,
                     marsha_msgs::MoveCmd::Response &res)
        { 
            //std::string pose_name = req.pose_name;
            ROS_DEBUG("Going to pose: %s", req.pose_name.c_str());

            std::string param = pose_param + req.pose_name + "/";
            geometry_msgs::Pose target_pose;


            ros::param::get(param + "position/x", target_pose.position.x);
            ros::param::get(param + "position/y", target_pose.position.y);       
            ros::param::get(param + "position/z", target_pose.position.z);
            ros::param::get(param + "orientation/x", target_pose.orientation.x);
            ros::param::get(param + "orientation/y", target_pose.orientation.y);
            ros::param::get(param + "orientation/z", target_pose.orientation.z);
            ros::param::get(param + "orientation/w", target_pose.orientation.w);

            move_group->setPoseTarget(target_pose);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");
            move_group->move();

            res.done = success;
            return true;            
        }

        bool positionCmd(marsha_msgs::PositionCmd::Request &req,
                         marsha_msgs::PositionCmd::Response &res) {

            geometry_msgs::Pose target_pose;

            ros::param::get("/left/pose/pickup/orientation/x", target_pose.orientation.x);
            ros::param::get("/left/pose/pickup/orientation/y", target_pose.orientation.y);
            ros::param::get("/left/pose/pickup/orientation/z", target_pose.orientation.z);
            ros::param::get("/left/pose/pickup/orientation/w", target_pose.orientation.w);

            // Do not allow gripper to collide with ground
            float z_collision;
            ros::param::get("/hyperparameters/z_collision", z_collision);
            if (req.position.z < z_collision) {
                ROS_WARN("Attempted to move gripper below ground! System automatically prevented collision.");
                req.position.z = z_collision;
            }
            target_pose.position = req.position;


            move_group->setPoseTarget(target_pose);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            

            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_INFO("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");

            if (success) {
                move_group->asyncExecute(target_plan);
            }
            


            res.done = success;
            return true;            
            

        }

        bool graspCmd(marsha_msgs::MoveCmd::Request &req,
                    marsha_msgs::MoveCmd::Response &res)
        {

            ROS_DEBUG("Gripping pose: %s", req.pose_name.c_str());
            std::string param = "/gripper/" + req.pose_name + "/";
            std::vector<double> joint_targets(2);


            ros::param::get(param + "left", joint_targets[0]);
            ros::param::get(param + "right", joint_targets[1]);


            ROS_DEBUG("Value targets: %f, %f", joint_targets[0], joint_targets[1]);

            hand_group->setJointValueTarget(joint_targets);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (hand_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");
            hand_group->move();

            res.done = success;
            return true;
        }

        // Return current pose
        bool getPose(marsha_msgs::GetPos::Request &req,
                     marsha_msgs::GetPos::Response &res)
        {
            geometry_msgs::Pose pose = move_group->getCurrentPose().pose;
            geometry_msgs::Point position = pose.position;
            geometry_msgs::Quaternion orientation = pose.orientation;

            ROS_DEBUG("Position [x: %f y: %f z: %f] Orientation [x: %f y: %f z: %f w: %f]", 
                      position.x, position.y, position.z, 
                      orientation.x, orientation.y, orientation.z, orientation.w
            );

            res.position = position;
            return true;
        }

    public:
        MarshaMoveInterface(ros::NodeHandle *nh) {
            move_group = new moveit::planning_interface::MoveGroupInterface(ARM_PLANNING_GROUP);
            hand_group = new moveit::planning_interface::MoveGroupInterface(GRIPPER_PLANNING_GROUP);

            float ik_timeout;

            ros::param::get(ros::this_node::getNamespace() + "/IK_timeout", ik_timeout);
            move_group->setPlanningTime(ik_timeout);
            
            poseService = nh->advertiseService("pose_cmd", &MarshaMoveInterface::poseCmd, this);

            positionService = nh->advertiseService("position_cmd", &MarshaMoveInterface::positionCmd, this);

            graspService = nh->advertiseService("grasp_cmd", &MarshaMoveInterface::graspCmd, this);

            getPosService = nh->advertiseService("get_pos", &MarshaMoveInterface::getPose, this);
            //position_sub = nh->subscribe("pos_cmd", 1000, &MarshaMoveInterface::positionCallBack, this);
            //get_pose_sub = nh->subscribe("get_state", 1000, &MarshaMoveInterface::getPose, this);

            pose_param = ros::this_node::getNamespace() + "/pose/";
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