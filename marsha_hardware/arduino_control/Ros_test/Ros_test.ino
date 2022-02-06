

#include "Stepper.h"
#include <ros.h>
#include <std_msgs/Int16.h>
#include <std_msgs/Int32MultiArray.h>



#define BAUD_RATE       115200
#define SPIN_RATE       100
#define FEEDBACK_RATE   1000
#define NUM_JOINTS      6

#define NUM_INFO        3
#define DEBUG_STEPPER    4


// Note: It should attempt to stay at zero when turned on, if it continuously spins in one direction, flip the direction
Stepper steppers[] = {Stepper(33, 34, 21, 22), Stepper(32, 31, 19, 20), Stepper(30, 29, 17, 18, true), Stepper(28, 27, 15, 16), Stepper(26, 25, 40, 41), Stepper(26, 25)};

int led = 13;
int spinCounter = 0;
int feedbackCounter = 0;

ros::NodeHandle nh;
std_msgs::Int32MultiArray feedback_multiArr;
int feedback_arr[NUM_JOINTS];

// Debug
std_msgs::Int32MultiArray info_feedback;
int info_arr[NUM_INFO];


void rosVELCallback(const std_msgs::Int16 &msg) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].set_speed(msg.data);
  }
  
}

void rosCMDCallback(const std_msgs::Int16 &msg) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[DEBUG_STEPPER].set_point(msg.data);
  }
  
}

ros::Publisher feedback_pub("enc_feedback", &feedback_multiArr);
ros::Subscriber<std_msgs::Int16> cmd_sub("cmd", &rosCMDCallback);
ros::Subscriber<std_msgs::Int16> vel_sub("vel", &rosVELCallback);

// debug
ros::Publisher info_pub("info_feedback", &info_feedback);

void sendFeedback() {
  for (int i = 0; i < NUM_JOINTS; i++) {
    feedback_arr[i] = steppers[i].get_enc_step();
  }
  feedback_pub.publish(&feedback_multiArr);

  // debug
  info_arr[0] = steppers[DEBUG_STEPPER].current_step;
  info_arr[1] = steppers[DEBUG_STEPPER].get_speed();
  info_arr[2] = (int)steppers[DEBUG_STEPPER].error_sum;
 
  
  info_pub.publish(&info_feedback);
  
}




void stepper_power_callback() {
  Stepper::stepper_power = digitalRead(STEPPER_POWER_PIN);
  digitalWrite(13, Stepper::stepper_power);
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].update_step_cnt();
  }
}

void setup() {
  feedback_multiArr.data_length = NUM_JOINTS;
  feedback_multiArr.data = feedback_arr;

  info_feedback.data_length = NUM_INFO;
  info_feedback.data = info_arr;
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);

  nh.getHardware()->setBaud(BAUD_RATE);
  nh.initNode();
  nh.subscribe(cmd_sub);
  nh.subscribe(vel_sub);
  nh.advertise(feedback_pub);

  // debug
  nh.advertise(info_pub);

  steppers[0].tune_controller(0.6, 0.00001, 20, 175);
  steppers[1].tune_controller(0.6, 0.00001, 40, 75);
  steppers[2].tune_controller(1, 0.0001, 10, 75);
  steppers[3].tune_controller(0.6, 0.00001, 10, 150);

  Stepper::setSteppers(steppers, 6);

  // Interrupt sets stepper_power to current power state on change
  attachInterrupt(STEPPER_POWER_PIN, stepper_power_callback, CHANGE);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (spinCounter > SPIN_RATE) {
    nh.spinOnce();
    spinCounter = 0;
  }
  if (feedbackCounter > FEEDBACK_RATE) {
    sendFeedback();
    feedbackCounter = 0;
  }

  spinCounter++;
  feedbackCounter++;
}
