/*
* Creates a service is_grasped which can be called to determine whether an object is grasped or not

* Input: Empty

* Output: Bool

* Author: Aaron Borger <borger.aaron@gmail.com>
*/

#include <ros/ros.h>
#include <std_msgs/Empty.h>
#include <std_srvs/Trigger.h>
//#include <gazebo_grasp_plugin_ros/GazeboGraspEvent.h>

class GraspedStateServer {
    private:
        bool grasped_state;

        ros::ServiceServer isGrasped;

        ros::Subscriber grasp_topic_sub;

        bool getGraspedState(std_srvs::Trigger::Request &req,
                             std_srvs::Trigger::Response &res)
        {
            res.success = grasped_state;
            return true;
        }

        void graspEventCallBack(const gazebo_grasp_plugin_ros::GazeboGraspEvent::ConstPtr& msg)
        {
            grasped_state = msg->attached;
        }

    public:
        GraspedStateServer(ros::NodeHandle *nh)
        {
            isGrasped = nh->advertiseService("is_grasped", &GraspedStateServer::getGraspedState, this);

            grasp_topic_sub = nh->subscribe(ros::this_node::getNamespace() + "/grasp_event_republisher/grasp_events", 10, &GraspedStateServer::graspEventCallBack, this);
        }
};


int main(int argc, char** argv)
{
    ros::init(argc, argv, "grasped_state_server");
    ros::NodeHandle nh;
    ros::AsyncSpinner spinner(4);
    spinner.start();

    GraspedStateServer server = GraspedStateServer(&nh);
    ros::waitForShutdown();
}
