/*
* Creates two services pos_cmd and grasp_cmd

* These services take a string as input which corresponds to a pose param file

* The service then performs the pose

* Author: Aaron Borger <borger.aaron@gmail.com>

*/



#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

/*
#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include <moveit_visual_tools/moveit_visual_tools.h>
*/
#include <ros/ros.h>
#include <geometry_msgs/Pose.h>

#include <std_msgs/Empty.h>
#include <std_srvs/Trigger.h>
#include <string>

#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Point.h>

#include <marsha_msgs/MoveCmd.h>
#include <marsha_msgs/PositionCmd.h>
#include <marsha_msgs/GetPos.h>
#include <marsha_msgs/PostureCmd.h>
#include <marsha_msgs/PlanGrasp.h>
#include <marsha_msgs/JointCmd.h>
#include <marsha_msgs/TeensyMsg.h>

#include <trajectory_msgs/JointTrajectoryPoint.h>
#include <trajectory_msgs/MultiDOFJointTrajectoryPoint.h>


// Testing
#include <iostream>
#include <iterator>
// ------

#include <vector>

struct GraspPlan {
    moveit::planning_interface::MoveGroupInterface::Plan pre_grasp;
    moveit::planning_interface::MoveGroupInterface::Plan grasp;
};

static const std::string ARM_PLANNING_GROUP = "manipulator";

class MarshaMoveInterface {
    private:
        moveit::planning_interface::MoveGroupInterface* move_group;

        // Used for toggling collision objects, could maybe be put in a different file
        moveit::planning_interface::PlanningSceneInterface planning_scene_interface;
        
        ros::ServiceServer poseService;
        ros::ServiceServer asyncPoseService;
        ros::ServiceServer jointPoseService;
        ros::ServiceServer asyncJointPoseService;
        ros::ServiceServer jointCmdService;
        ros::ServiceServer positionService;
        ros::ServiceServer getPosService;
        ros::ServiceServer postureService;
        ros::ServiceServer planGraspService;
        ros::ServiceServer toggleCollisionsService;
        //ros::Subscriber position_sub;
        ros::Subscriber get_obj_pos;
        ros::Subscriber get_person_pos;

        ros::ServiceClient graspClient;
        ros::ServiceClient teensyCmdState;

        std::string pose_param;
        std::string joint_param;
        
        int num_joints = 6;

        // Default RTT planning timeout
        float ik_timeout = 0.07;


        bool poseCmd(marsha_msgs::MoveCmd::Request &req,
                     marsha_msgs::MoveCmd::Response &res)
        { 
            //std::string pose_name = req.pose_name;
            

            std::string param = pose_param + req.pose_name + "/";
            geometry_msgs::Pose target_pose;
            ROS_INFO("Going to pose: %s", param.c_str());


            ros::param::get(param + "position/x", target_pose.position.x);
            ros::param::get(param + "position/y", target_pose.position.y);       
            ros::param::get(param + "position/z", target_pose.position.z);
            ros::param::get(param + "orientation/x", target_pose.orientation.x);
            ros::param::get(param + "orientation/y", target_pose.orientation.y);
            ros::param::get(param + "orientation/z", target_pose.orientation.z);
            ros::param::get(param + "orientation/w", target_pose.orientation.w);

            ROS_INFO("Target_pose x: %f", target_pose.position.x);

            move_group->setPoseTarget(target_pose);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");
            move_group->execute(target_plan);

            res.done = success;
            return true;            
        }

        // Exact same as poseCmd, but doesn't block
        bool asyncPoseCmd(marsha_msgs::MoveCmd::Request &req,
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
            move_group->asyncExecute(target_plan);

            res.done = success;
            return true;            
        }


        // Note: joint values in yaml file must be in radians
        // TODO: Convert this to trajectory
        bool jointPoseCmd(marsha_msgs::MoveCmd::Request &req,
                      marsha_msgs::MoveCmd::Response &res)
        {
            // Check if param is there to prevent going back home with unkown params
            std::string param =  joint_param + req.pose_name + "/";
            ROS_INFO("Going to joint state: %s", param.c_str());

            std::vector<double> joint_group_positions;

            ros::param::get(param, joint_group_positions);

            while (joint_group_positions.size() < num_joints) {
                joint_group_positions.push_back(0.0);
            }

            move_group->setJointValueTarget(joint_group_positions);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool plan_success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", plan_success ? "SUCCESSFUL" : "FAILED");

            if (plan_success) {
                move_group->execute(target_plan);

                std_srvs::Trigger srv;
                bool cmd_executed = false;

                while (!cmd_executed) {
                    teensyCmdState.call(srv);
                    if (srv.response.message == "fail") {
                        res.done = false;
                        throw std::runtime_error("Could not complete move.");
                        return true;
                    }
                    else {
                        cmd_executed = srv.response.success;
                        ros::Duration(0.1).sleep();
                    }
                }
                res.done = true;
                return true;
            }
            else {
                res.done = false;
                throw std::runtime_error("Could not plan move.");
                return false;
            }

        }

        // Exact same as jointPoseCmd, but doesn't block
        bool asyncJointPoseCmd(marsha_msgs::MoveCmd::Request &req,
                          marsha_msgs::MoveCmd::Response &res)
        { 
            std::string param =  joint_param + req.pose_name + "/";
            ROS_INFO("Going to joint state: %s", param.c_str());

            std::vector<double> joint_group_positions;

            ros::param::get(param, joint_group_positions);

            while (joint_group_positions.size() < num_joints) {
                joint_group_positions.push_back(0.0);
            }

            move_group->setJointValueTarget(joint_group_positions);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", success ? "SUCCESSFUL" : "FAILED");



            if (success) {
                move_group->asyncExecute(target_plan);
                res.done = success;
                return true;
            }
            else {
                res.done = false;
                return false;
            }            
        }

        bool jointCmd(marsha_msgs::JointCmd::Request &req,
                      marsha_msgs::JointCmd::Response &res) 
        {
            ROS_INFO("First angle: %f", req.joint_angle[0]);
            std::vector<double> joint_group_positions;

            for (int i = 0; i < 6; i++) {
                joint_group_positions.push_back(req.joint_angle[i]);
            }

            move_group->setJointValueTarget(joint_group_positions);

            moveit::planning_interface::MoveGroupInterface::Plan target_plan;

            bool plan_success = (move_group->plan(target_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
            ROS_DEBUG("Plan status: %s", plan_success ? "SUCCESSFUL" : "FAILED");

            if (plan_success) {
                move_group->execute(target_plan);
                res.done = true;
                return true;
            }
            else {
                res.done = false;
                return false;
            }

        }

        // Moveit has cartesian path planning with waypoints, but either it is broken or I cannot get it to work
        // Errors involve waypoints not stricly increasing in time and not having a reliable success rate for planning the path.
        // Also moveit does not provide any documentation for how to execute the trajectory after planning it.

        // Moveit RobotModel also provides a distance function between different states which could be usefull for ensuring the planned path
        // is optimized to the shortest path

        
        bool planGrasp(marsha_msgs::PlanGrasp::Request &req,
                       marsha_msgs::PlanGrasp::Response &res) {
            // Open gripper before planning TODO: Ensure this does not block as that would slow down planning
            bool g_success = grasp("open");

            // Plan maneuver to preGrasp position
            move_group->setPoseTarget(req.preGrasp);
            GraspPlan grasp_plan;
            res.pre_grasp_success = (move_group->plan(grasp_plan.pre_grasp) == moveit::planning_interface::MoveItErrorCode::SUCCESS); // Plan and check if succeeded
            ROS_INFO("Pre Grasp plan: %s", res.pre_grasp_success ? "SUCCESSFUL" : "FAILED");


            // TODO: Plan preGrasp and grasp simultaneously
            // Current method plans pregrasp then grasp if successfull, this causes the arm to move to preGrasp even if postGrasp isnt possible
            if (res.pre_grasp_success) {
                ROS_INFO("Pre grasp success");
                move_group->execute(grasp_plan.pre_grasp);
                /*
                // An attempt at constraining to the grasp vector. It doesnt work great, but is ok for now I suppose
                moveit_msgs::OrientationConstraint ocm;
                ocm.link_name = "gripper_connector";
                ocm.header.frame_id = "world";
                ocm.orientation = req.preGrasp.orientation;
                ocm.absolute_x_axis_tolerance = 0.1;
                ocm.absolute_y_axis_tolerance = 0.1;
                ocm.absolute_z_axis_tolerance = 0.1;
                ocm.weight = 1.0;

                moveit_msgs::Constraints ee_constraint;
                ee_constraint.orientation_constraints.push_back(ocm);
                move_group->setPathConstraints(ee_constraint);

                robot_state::RobotState start_state(*move_group->getCurrentState());
                move_group->setStartState(start_state);
                

                /* Other constraint method
                planning_interface::MotionPlanRequest motionReq;
                planning_interface::MotionPlanResponse motionRes;
                planning_interface::PlannerManagerPtr planner_interface;
                geometry_msgs::PoseStamped grasp_pose;

                motionReq.group_name = ARM_PLANNING_GROUP;
                grasp_pose.header.frame_id = "base_link";
                std::vector<double> tolerance_pose(3, 0.01);
                std::vector<double> tolerance_angle(3, 0.01);

                grasp_pose.pose = req.Grasp;
                moveit_msgs::Constrains grasp_pose_goal = 
                    kinematic_constraints::constructGoalConstraints("gripper_connector", grasp_pose, tolerance_pose, tolerance_angle);

                // Add path constraint
                geometry_msgs::QuaternionStamped constraint_quaternion;
                constraint_quaternion.header.frame_id = "base_link";
                constraint_quaternion.quaternion = req.Grasp.orientation;
                req.path_constraints = kinematic_constraints::constructGoalConstraints("gripper_connector", constraint_quaternion);
                
                // Set bounding box for arm workspace from (-1, 1) for all directions.
                req.workspace_parameters.min_corner.x = req.workspace_parameters.min_corner.y = req.workspace_parameters.min_corner.z = -1.0;
                req.workspace_parameters.max_corner.x = req.workspace_parameters.max_corner.y = req.workspace_parameters.max_corner.z = 1.0;

                planning_interfacce::PlanningContextPtr context = 
                */

                move_group->setPoseTarget(req.Grasp);
                res.grasp_success = (move_group->plan(grasp_plan.grasp) == moveit::planning_interface::MoveItErrorCode::SUCCESS); // Plan and check if succeeded
                ROS_INFO("Grasp plan: %s", res.grasp_success ? "SUCCESSFUL" : "FAILED");

                // Perform grasp if successful
                if (res.grasp_success) {
                    ROS_INFO("Grasp success");
                    ROS_INFO("Now: %f, grasp: %f", ros::Time::now().toSec(), req.time_to_maneuver.data.toSec());
                    while (ros::Time::now() < req.time_to_maneuver.data) {
                        // Not a good way of waiting because it blocks
                        ros::Duration(0.1).sleep();
                    }
                    
                    // Move to grasp, wait grasp time, then close gripper
                    move_group->asyncExecute(grasp_plan.grasp);
                    ros::Duration(req.grasp_time.data).sleep();
                    res.gripper_success = grasp("close");
                }

                move_group->clearPathConstraints();

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
            marsha_msgs::MoveCmd grasp_cmd;
            grasp_cmd.request.pose_name = param;
            bool success = graspClient.call(grasp_cmd);
            if (success) {ROS_INFO("Grasp %s success!", param.c_str());} else {ROS_INFO("Grasp %s fail!", param.c_str());}

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

        // Request of on adds collision objects request of off removes them
        // TODO: make this a bool service
        // TODO: develop mechanism to prevent turning on if already on 
        bool toggleCollisions(marsha_msgs::MoveCmd::Request &req,
                              marsha_msgs::MoveCmd::Response &res) {
            if (req.pose_name == "add") {
                // Vector holds collision objects
                std::vector<moveit_msgs::CollisionObject> collision_objects;
                collision_objects.resize(1);

                // Add payload divider
                collision_objects[0].id = "payload_divider";
                collision_objects[0].header.frame_id = "base_link";

                collision_objects[0].primitives.resize(1);
                collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].BOX;
                collision_objects[0].primitives[0].dimensions.resize(3);
                collision_objects[0].primitives[0].dimensions[0] = 0.01;
                collision_objects[0].primitives[0].dimensions[1] = 0.29;
                collision_objects[0].primitives[0].dimensions[2] = 0.19;

                collision_objects[0].primitive_poses.resize(1);
                collision_objects[0].primitive_poses[0].position.x = 0.07;
                collision_objects[0].primitive_poses[0].position.y = -0.09;
                collision_objects[0].primitive_poses[0].position.z = 0.18;

                planning_scene_interface.applyCollisionObjects(collision_objects);

                res.done = true;

            } 
            else if (req.pose_name == "remove") {
                std::vector<std::string> object_ids;
                object_ids.push_back("payload_divider");
                planning_scene_interface.removeCollisionObjects(object_ids);
                res.done = true;
            }
            else {
                ROS_WARN(" %s is not a toggleCollisions option. Only 'add' and 'remove' are allowed.", req.pose_name.c_str());
                return false;
            }
            return true;
        }

    void visualizePerson (const geometry_msgs::Point::ConstPtr& msg) {
        ROS_INFO("Vizualizing...");
        std::vector<std::string> object_ids;
        object_ids.push_back("person");
        planning_scene_interface.removeCollisionObjects(object_ids);

        std::vector<moveit_msgs::CollisionObject> collision_objects;
        collision_objects.resize(1);

        collision_objects[0].id = "ball";
        collision_objects[0].header.frame_id = "base_link";

        collision_objects[0].primitives.resize(1);
        collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].BOX;
        collision_objects[0].primitives[0].dimensions.resize(3);
        collision_objects[0].primitives[0].dimensions[0] = 0.1;
        collision_objects[0].primitives[0].dimensions[1] = 0.1;
        collision_objects[0].primitives[0].dimensions[2] = 0.3;

        collision_objects[0].primitive_poses.resize(1);
        collision_objects[0].primitive_poses[0].position.x = msg->x;
        collision_objects[0].primitive_poses[0].position.y = msg->y;
        collision_objects[0].primitive_poses[0].position.z = msg->z;
        collision_objects[0].primitive_poses[0].orientation.x = 0;
        collision_objects[0].primitive_poses[0].orientation.y = 0;
        collision_objects[0].primitive_poses[0].orientation.z = 0;
        collision_objects[0].primitive_poses[0].orientation.w = 1;


        ROS_INFO("Object set at %f, %f, %f", msg->x, msg->y, msg->z);

        planning_scene_interface.applyCollisionObjects(collision_objects);
    }

    void visualizeObject (const geometry_msgs::Point::ConstPtr& msg) {
        ROS_INFO("Vizualizing...");
        std::vector<std::string> object_ids;
        object_ids.push_back("ball");
        planning_scene_interface.removeCollisionObjects(object_ids);

        std::vector<moveit_msgs::CollisionObject> collision_objects;
        collision_objects.resize(1);

        collision_objects[0].id = "ball";
        collision_objects[0].header.frame_id = "base_link";

        collision_objects[0].primitives.resize(1);
        collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].SPHERE;
        collision_objects[0].primitives[0].dimensions.resize(1);
        collision_objects[0].primitives[0].dimensions[0] = 0.035;

        collision_objects[0].primitive_poses.resize(1);
        collision_objects[0].primitive_poses[0].position.x = msg->x;
        collision_objects[0].primitive_poses[0].position.y = msg->y;
        collision_objects[0].primitive_poses[0].position.z = msg->z;
        collision_objects[0].primitive_poses[0].orientation.x = 0;
        collision_objects[0].primitive_poses[0].orientation.y = 0;
        collision_objects[0].primitive_poses[0].orientation.z = 0;
        collision_objects[0].primitive_poses[0].orientation.w = 1;


        ROS_INFO("Object set at %f, %f, %f", msg->x, msg->y, msg->z);

        planning_scene_interface.applyCollisionObjects(collision_objects);
    }

    public:
        MarshaMoveInterface(ros::NodeHandle *nh) {
            move_group = new moveit::planning_interface::MoveGroupInterface(ARM_PLANNING_GROUP);
            //hand_group = new moveit::planning_interface::MoveGroupInterface(GRIPPER_PLANNING_GROUP);

            

            ros::param::get(ros::this_node::getNamespace() + "/IK_timeout", ik_timeout);
            ROS_INFO("Planning time: %f", ik_timeout);
            move_group->setPlanningTime(ik_timeout);
            
            poseService = nh->advertiseService("pose_cmd", &MarshaMoveInterface::poseCmd, this);
            asyncPoseService = nh->advertiseService("async_pose_cmd", &MarshaMoveInterface::asyncPoseCmd, this);

            jointPoseService = nh->advertiseService("joint_pose_cmd", &MarshaMoveInterface::jointPoseCmd, this);
            asyncJointPoseService = nh->advertiseService("async_joint_pose_cmd", &MarshaMoveInterface::asyncJointPoseCmd, this);

            jointCmdService = nh->advertiseService("joint_cmd", &MarshaMoveInterface::jointCmd, this);

            positionService = nh->advertiseService("position_cmd", &MarshaMoveInterface::positionCmd, this);

            //graspService = nh->advertiseService("grasp_cmd", &MarshaMoveInterface::graspCmd, this);
            graspClient = nh->serviceClient<marsha_msgs::MoveCmd>("gripper/grasp_cmd");
            teensyCmdState = nh->serviceClient<std_srvs::Trigger>("teensy_cmd_executed");

            getPosService = nh->advertiseService("get_pos", &MarshaMoveInterface::getPose, this);
            //position_sub = nh->subscribe("pos_cmd", 1000, &MarshaMoveInterface::positionCallBack, this);
            //get_obj_pos = nh->subscribe("/object_pos", 100, &MarshaMoveInterface::visualizeObject, this);
            //get_person_pos = nh->subscribe("/person_pos", 100, &MarshaMoveInterface::visualizePerson, this);

            postureService = nh->advertiseService("posture_cmd", &MarshaMoveInterface::postureCmd, this);

            planGraspService = nh->advertiseService("plan_grasp", &MarshaMoveInterface::planGrasp, this);

            toggleCollisionsService = nh->advertiseService("toggle_collisions", &MarshaMoveInterface::toggleCollisions, this);

            // The marsha_hardware package has a second method to get num_joints
            // ros::param::get("stepper_config/num_joints", num_joints);
            // TODO: Consolidate these two params
            ros::param::get(ros::this_node::getNamespace() + "/stepper_config/num_joints", num_joints);
            ROS_INFO("Running with %i joints", num_joints);

            pose_param = ros::this_node::getNamespace() + "/pose/";
            joint_param = ros::this_node::getNamespace() + "/joints/";
            //pose_param = "/hardware/pose/";
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