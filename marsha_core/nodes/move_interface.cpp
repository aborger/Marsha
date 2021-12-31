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
#include "marsha_msgs/PostureCmd.h"
#include "marsha_msgs/PlanGrasp.h"

#include <std_msgs/Empty.h>
#include <string>

#include <geometry_msgs/Pose.h>


#include <vector>

struct GraspPlan {
    moveit::planning_interface::MoveGroupInterface::Plan pre_grasp;
    moveit::planning_interface::MoveGroupInterface::Plan grasp;
};

static const std::string ARM_PLANNING_GROUP = "manipulator";

class MarshaMoveInterface {
    private:
        moveit::planning_interface::MoveGroupInterface* move_group;
        
        ros::ServiceServer poseService;
        ros::ServiceServer positionService;
        ros::ServiceServer getPosService;
        ros::ServiceServer postureService;
        ros::ServiceServer planGraspService;
        //ros::Subscriber position_sub;
        ros::Subscriber get_pose_sub;

        ros::ServiceClient graspClient;

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


        bool planGrasp(marsha_msgs::PlanGrasp::Request &req,
                       marsha_msgs::PlanGrasp::Response &res) {
            std::string param = "open";
            bool g_success = grasp(param);
            move_group->setPoseTarget(req.preGrasp);
            GraspPlan grasp_plan;

            bool pre_grasp_success = (move_group->plan(grasp_plan.pre_grasp) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            if (pre_grasp_success) {
                move_group->execute(grasp_plan.pre_grasp);
                move_group->setPoseTarget(req.Grasp);
                bool grasp_success = (move_group->plan(grasp_plan.grasp) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
                if (grasp_success) {
                    param = "close";
                    ROS_INFO("Now: %f, grasp: %f", ros::Time::now().toSec(), req.time_offset.data.toSec());
                    while (ros::Time::now() < req.time_offset.data) {
                        // Not good way of waiting because it blocks
                        ros::Duration(0.1).sleep();
                    }
                    
                    move_group->asyncExecute(grasp_plan.grasp);
                    ros::Duration(req.grasp_time.data).sleep();
                    g_success = grasp(param);

                    res.success = true;
                } else {
                    res.success = false;
                }
            }
            else {
                res.success = false;
            }
            
            return true;
        }

        // This should be named poseCmd and poseCmd should be deleted because
        // it was made before I understood quaternions
        bool postureCmd(marsha_msgs::PostureCmd::Request &req,
                        marsha_msgs::PostureCmd::Response &res) {
            
            geometry_msgs::Pose target_pose;
            target_pose = req.posture;



            move_group->setPoseTarget(target_pose);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_INFO("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");

            if (success) {
                move_group->execute(target_plan);
            }
            


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

        bool grasp(std::string param) {
            ROS_INFO("Grasping...");
            marsha_msgs::MoveCmd grasp_cmd;
            grasp_cmd.request.pose_name = param;
            bool success = graspClient.call(grasp_cmd);
            if (success) {ROS_INFO("Grasp success");} else {ROS_INFO("Grasp Fail");}

            return success;
        }        

        bool graspCmd(marsha_msgs::MoveCmd::Request &req,
                    marsha_msgs::MoveCmd::Response &res)
        {

            ROS_DEBUG("Gripping pose: %s", req.pose_name.c_str());
            std::string param = "/gripper/" + req.pose_name;
            bool success = grasp(param);

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
            //hand_group = new moveit::planning_interface::MoveGroupInterface(GRIPPER_PLANNING_GROUP);

            float ik_timeout;

            ros::param::get(ros::this_node::getNamespace() + "/IK_timeout", ik_timeout);
            move_group->setPlanningTime(ik_timeout);
            
            poseService = nh->advertiseService("pose_cmd", &MarshaMoveInterface::poseCmd, this);

            positionService = nh->advertiseService("position_cmd", &MarshaMoveInterface::positionCmd, this);

            //graspService = nh->advertiseService("grasp_cmd", &MarshaMoveInterface::graspCmd, this);
            graspClient = nh->serviceClient<marsha_msgs::MoveCmd>("gripper/grasp_cmd");

            getPosService = nh->advertiseService("get_pos", &MarshaMoveInterface::getPose, this);
            //position_sub = nh->subscribe("pos_cmd", 1000, &MarshaMoveInterface::positionCallBack, this);
            //get_pose_sub = nh->subscribe("get_state", 1000, &MarshaMoveInterface::getPose, this);

            postureService = nh->advertiseService("posture_cmd", &MarshaMoveInterface::postureCmd, this);

            planGraspService = nh->advertiseService("plan_grasp", &MarshaMoveInterface::planGrasp, this);

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