#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>

#include <ros/ros.h>
#include "marsha_ai/Pos.h"

static const std::string PLANNING_GROUP = "manipulator";

class MarshaMoveInterface {
    private:
    moveit::planning_interface::MoveGroupInterface* move_group;
    const robot_state::JointModelGroup* joint_model_group;
    ros::Subscriber position_sub;

    void positionCallBack(const marsha_ai::Pos::ConstPtr& msg)
    {
        ROS_INFO("Taking action[ x: %f y: %f z: %f", msg->x, msg->y, msg->z);
        
        setPose(msg->x, msg->y, msg->z);

    }

    public:
    MarshaMoveInterface(ros::NodeHandle *nh) {
        move_group = new moveit::planning_interface::MoveGroupInterface(PLANNING_GROUP);
        joint_model_group = move_group->getCurrentState()->getJointModelGroup(PLANNING_GROUP);
        position_sub = nh->subscribe("pos_cmd", 1000, &MarshaMoveInterface::positionCallBack, this);
    }

    void setPose(float x_val, float y_val, float z_val)
    {
        geometry_msgs::Pose target_pose1;
        target_pose1.orientation.w = 0.5;
        target_pose1.orientation.x = -0.5;
        target_pose1.orientation.y = -0.5;
        target_pose1.orientation.z = 0.5;
        target_pose1.position.x = x_val;
        target_pose1.position.y = y_val;
        target_pose1.position.z = z_val;
        move_group->setPoseTarget(target_pose1);

        moveit::planning_interface::MoveGroupInterface::Plan target_plan;

        ROS_INFO("Getting success...");
        bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        ROS_INFO("Plan status: %s", success ? "" : "FAILED");
        move_group->move();
    }



};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "move_interface");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();
    MarshaMoveInterface interface = MarshaMoveInterface(&nh);
    //interface.setPose();
    ros::waitForShutdown();
}