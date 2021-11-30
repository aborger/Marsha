/* This is the header file for move_interface_v2
   not the version currently used

* It could be modified quickly to better organiz the current version

*/

typedef actionlib::SimpleActionServer<marsha_msgs::PositionCmdAction> PositionServer;

class MarshaMoveInterface
{
    private:
        moveit::planning_interface::MoveGroupInterface* move_group;
        moveit::planning_interface::MoveGroupInterface* hand_group;

        
        PositionServer* positionServer;

        ros::ServiceServer poseService;
        ros::ServiceServer graspService;
        ros::ServiceServer getPosService;
        //ros::Subscriber position_sub;
        ros::Subscriber get_pose_sub;

        std::string pose_param;
    public:

        MarshaMoveInterface(ros::NodeHandle *nh);
        bool poseCmd(marsha_ai::MoveCmd::Request &req,
                     marsha_ai::MoveCmd::Response &res);

        void positionCmd(const marsha_msgs::PositionCmdGoalConstPtr& goal);
        bool graspCmd(marsha_ai::MoveCmd::Request &req,
                    marsha_ai::MoveCmd::Response &res);

        bool getPose(marsha_msgs::GetPos::Request &req,
                     marsha_msgs::GetPos::Response &res);

        void positionPreemptCB();
};