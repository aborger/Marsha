#include "Stepper.h"
#include <ros.h>
#include <std_msgs/Int32.h>

ros::NodeHandle nh;


int led = 13;
int joint_number = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5)};


void selectCallBack(const std_msgs::Int32 &msg) {
  joint_number = msg.data;
}

void stepCallBack(const std_msgs::Int32 &msg) {
  stepper_array[joint_number].step(msg.data);
}

ros::Subscriber<std_msgs::Int32> select_sub("stepper_select", &selectCallBack);
ros::Subscriber<std_msgs::Int32> step_sub("stepper_step", &stepCallBack);

void setup() {
  nh.initNode();
  nh.subscribe(select_sub);
  nh.subscribe(step_sub);
}



void loop() {
  nh.spinOnce();
  delay(1);

}
