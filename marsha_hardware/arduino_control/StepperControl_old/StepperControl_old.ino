/* Controls hardware robot, input is the radian it should go to, it currently steps that amount.
 *  
 */
#include "Stepper.h"
#include <ros.h>
#include <std_msgs/Float64.h>

ros::NodeHandle nh;


int led = 13;
int joint_number = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5)};


void stepCallBack0(const std_msgs::Float64 &msg) {
  stepper_array[0].step_rad(msg.data);
}

void stepCallBack1(const std_msgs::Float64 &msg) {
  stepper_array[1].step_rad(msg.data);
}

ros::Subscriber<std_msgs::Float64> step_sub0("stepper_step0", &stepCallBack0);
ros::Subscriber<std_msgs::Float64> step_sub1("stepper_step1", &stepCallBack1);

void setup() {
  nh.initNode();
  nh.subscribe(step_sub0);
  nh.subscribe(step_sub1);
}



void loop() {
  nh.spinOnce();
  delay(1);

}
