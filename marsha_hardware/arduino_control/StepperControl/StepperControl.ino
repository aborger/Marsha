#include "Stepper.h"
#include <ros.h>
#include <control_msgs/FollowJointTrajectoryActionGoal.h>

typedef control_msgs::FollowJointTrajectoryActionGoal TrajectoryGoal

ros::NodeHandle nh;


int led = 13;
int joint_number = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5)};


void trajectoryCallBack(const TrajectoryGoal &msg) {
  float goal_position =  msg.trajectory.points.positions[0];
}



ros::Subscriber<TrajectoryGoal> trajectory_sub("/left/ar3/controllers/position/follow_joint_trajectory/goal", &trajectoryCallBack);

void setup() {
  nh.initNode();
  nh.subscribe(select_sub);
  nh.subscribe(step_sub);
}



void loop() {
  nh.spinOnce();
  delay(1);

}
