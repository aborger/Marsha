/* Controls hardware robot, input is the radian it should go to, it currently steps that amount.
 *  
 */
#include "Stepper.h"
#include <ros.h>
#include <std_msgs/Int32MultiArray.h>

#define NUM_JOINTS    6

#define LOG_FREQ      100



ros::NodeHandle nh;
std_msgs::Int32MultiArray feedback_multiArray;
long int feedback_arr[NUM_JOINTS];




int led = 13;
int num_loops = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5), Stepper(6,7), Stepper(8, 9), Stepper(10, 11), Stepper(12, 13)};

void callback(const std_msgs::Int32MultiArray &msg) {
  // data_offset == 69420 indicates this is a configuration header
  if (msg.layout.data_offset == 69420) {
    int step_delay = msg.layout.dim->stride;
    // Initialize stepper configuration
    stepper_array[0].init(step_delay);
  }

  else {
    // Set control setpoint
    for (int i = 0; i < NUM_JOINTS; i++) {
      stepper_array[i].set_point(msg.data[i]);
    }
  }
  
}

ros::Publisher feedback_pub("encoder_feedback", &feedback_multiArray);
ros::Subscriber<std_msgs::Int32MultiArray> step_sub("stepper_step", &callback);







void setup() {
  feedback_multiArray.data_length = NUM_JOINTS;
  feedback_multiArray.data = feedback_arr;
  
  nh.initNode();
  nh.subscribe(step_sub);
  nh.advertise(feedback_pub);
  
  
  
}



void loop() {
  nh.spinOnce();
  //for (int i = 0; i < NUM_JOINTS; i++) {
  stepper_array[0].control_step_pos();
  //}
  
  if (num_loops > LOG_FREQ) {
    for(int i = 0; i < NUM_JOINTS; i++) {
      feedback_arr[i] = stepper_array[i].get_current_step();
    }
    feedback_arr[0] = stepper_array[0].get_current_step();
    //feedback_arr[1] = stepper_array[0].get_desired_step(); // debug
    feedback_pub.publish(&feedback_multiArray);
    num_loops = 0;
  }
  num_loops++;
}
