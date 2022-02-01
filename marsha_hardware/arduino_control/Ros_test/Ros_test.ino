

#include "Stepper.h"
#include <ros.h>
#include <std_msgs/Int16.h>
#include <std_msgs/Int32MultiArray.h>



#define BAUD_RATE       115200
#define SPIN_RATE       1000
#define FEEDBACK_RATE   10000
#define NUM_JOINTS      6


// Note: It should attempt to stay at zero when turned on, if it continuously spins in one direction, flip the direction
Stepper steppers[] = {Stepper(33, 34, 21, 22), Stepper(32, 31, 19, 20), Stepper(30, 29, 17, 18, true), Stepper(28, 27, 15, 16), Stepper(28, 27), Stepper(26, 25)};

int led = 13;
int spinCounter = 0;
int feedbackCounter = 0;

ros::NodeHandle nh;
std_msgs::Int32MultiArray feedback_multiArr;
int feedback_arr[NUM_JOINTS];

// debug
std_msgs::Int16 step_feedback;
std_msgs::Int16 vel_feedback;

void rosVELCallback(const std_msgs::Int16 &msg) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].set_speed(msg.data);
  }
  
}

void rosCMDCallback(const std_msgs::Int16 &msg) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[2].set_point(msg.data);
  }
  
}

ros::Publisher feedback_pub("enc_feedback", &feedback_multiArr);
ros::Subscriber<std_msgs::Int16> cmd_sub("cmd", &rosCMDCallback);
ros::Subscriber<std_msgs::Int16> vel_sub("vel", &rosVELCallback);

// debug
ros::Publisher step_feedback_pub("step_feedback", &step_feedback);
ros::Publisher vel_feedback_pub("vel_feedback", &vel_feedback);

void sendFeedback() {
  for (int i = 0; i < NUM_JOINTS; i++) {
    feedback_arr[i] = steppers[i].get_enc_step();
  }
  feedback_pub.publish(&feedback_multiArr);

  // debug
  step_feedback.data = steppers[1].get_off_time();
  vel_feedback.data = steppers[1].get_speed();
  
  step_feedback_pub.publish(&step_feedback);
  vel_feedback_pub.publish(&vel_feedback);
  
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
  // put your setup code here, to run once:
  pinMode(led, OUTPUT);

  nh.getHardware()->setBaud(BAUD_RATE);
  nh.initNode();
  nh.subscribe(cmd_sub);
  nh.subscribe(vel_sub);
  nh.advertise(feedback_pub);

  // debug
  nh.advertise(step_feedback_pub);
  nh.advertise(vel_feedback_pub);


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
