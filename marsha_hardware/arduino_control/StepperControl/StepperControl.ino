#include "Stepper.h"
#include <ros.h>
#include <control_msgs/FollowJointTrajectoryGoal.h>

typedef control_msgs::FollowJointTrajectoryGoal TrajectoryGoal;

ros::NodeHandle nh;


int led = 13;
int joint_number = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5)};


void trajectoryCallBack(const TrajectoryGoal &msg) {
  //float goal_position =  msg.trajectory.points[0].positions[0];
  stepper_array[1].step(25000);
}



ros::Subscriber<TrajectoryGoal> trajectory_sub("/left/ar3/controllers/position/follow_joint_trajectory/goal", &trajectoryCallBack);


void setup() {
  nh.initNode();
  nh.subscribe(trajectory_sub);
}



void loop() {
  nh.spinOnce();
  delay(1);

}
