#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>

#include <ros/ros.h>
#include "marsha_ai/Pose.h" // Replace with geometry_msgs/Pose.msg
#include "marsha_ai/MoveCmd.h"
#include <std_msgs/Empty.h>
#include <string>


#include <vector>

static const std::string PLANNING_GROUP = "manipulator";

class MarshaMoveInterface {
    private:
        moveit::planning_interface::MoveGroupInterface* move_group;
        
        ros::ServiceServer positionService;
        //ros::Subscriber position_sub;
        ros::Subscriber get_pose_sub;

        std::string pose_param;

        // Move to pose
        /*
        bool positionCmd(marsha_ai::MoveCmd::Request &req,
                              marsha_ai::MoveCmd::Response &res)
        {
            ROS_INFO("Taking action[ x: %f y: %f z: %f", req.pos.x, req.pos.y, req.pos.z);
                    
            geometry_msgs::Pose target_pose1;
            target_pose1.orientation.w = req.orient.w;
            target_pose1.orientation.x = req.orient.x;
            target_pose1.orientation.y = req.orient.y;
            target_pose1.orientation.z = req.orient.z;
            target_pose1.position.x = req.pos.x;
            target_pose1.position.y = req.pos.y;
            target_pose1.position.z = req.pos.z;
            move_group->setPoseTarget(target_pose1);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            ROS_INFO("Getting success...");
            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_INFO("Plan status: %s", success ? "" : "FAILED");
            move_group->move();

            res.done = true;
            return true;

        }
        */
        bool poseCmd(marsha_ai::MoveCmd::Request &req,
                     marsha_ai::MoveCmd::Response &res)
        { 
            //std::string pose_name = req.pose_name;
            ROS_INFO("Going to pose: %s", req.pose_name.c_str());

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
            ROS_INFO("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");
            move_group->move();

            res.done = success;
            return true;            
        }

        // Return current pose
        void getPose(const std_msgs::Empty::ConstPtr& msg)
        {
            geometry_msgs::Pose pose = move_group->getCurrentPose().pose;
            geometry_msgs::Point position = pose.position;
            geometry_msgs::Quaternion orientation = pose.orientation;

            ROS_INFO("Position [x: %f y: %f z: %f] Orientation [x: %f y: %f z: %f w: %f]", 
                      position.x, position.y, position.z, 
                      orientation.x, orientation.y, orientation.z, orientation.w
            );
        }

    public:
        MarshaMoveInterface(ros::NodeHandle *nh) {
            move_group = new moveit::planning_interface::MoveGroupInterface(PLANNING_GROUP);
            
            positionService = nh->advertiseService("pos_cmd", &MarshaMoveInterface::poseCmd, this);

            //position_sub = nh->subscribe("pos_cmd", 1000, &MarshaMoveInterface::positionCallBack, this);
            get_pose_sub = nh->subscribe("get_state", 1000, &MarshaMoveInterface::getPose, this);

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