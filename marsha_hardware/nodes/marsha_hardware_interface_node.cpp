#include <controller_manager/controller_manager.h>
#include <marsha_hardware/arm2d2_hardware_interface.h>
#include <marsha_hardware/ar3_hardware_interface.h>

typedef AR3Interface MarshaArm;

int main(int argc, char** argv)
{
    
    ROS_INFO("Starting node");
    ros::init(argc, argv, "marsha_hardware_interface");

    ros::NodeHandle nh;

    MarshaArm arm(nh);


    controller_manager::ControllerManager cm(&arm);

    ros::AsyncSpinner spinner(1);
    spinner.start();

    ros::Time prev_time = ros::Time::now();
    ros::Rate rate(10.0);


    while(ros::ok()) {
        const ros::Time time = ros::Time::now();
        const ros::Duration period = time - prev_time;

        arm.read();

        cm.update(time, period);


        arm.write();

        rate.sleep();
    }


    return 0;
}