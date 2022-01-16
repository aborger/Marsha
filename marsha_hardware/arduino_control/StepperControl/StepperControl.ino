/*
 * Marsha Stepper Control System, currently configured for the AR3.
 * 
 * Takes Int16MultiArray as position input for each joint from ROS and moves steppers to desired position using a timer interrupt for exact step times.
 * 
 * Author: Aaron Borger
 */

#include <ros.h>
#include <std_msgs/Int16MultiArray.h>
#include "Stepper.h"
#include "TimerOne.h"

#define NUM_JOINTS      6
#define TIMER_INTERVAL  50
#define FEEDBACK_RATE   10000
#define SPIN_RATE       1000
#define BAUD_RATE       115200




// Declare ROS data types
ros::NodeHandle nh;
std_msgs::Int16MultiArray feedback_multiArr; // Msg that is transmitted to ROS (contains feedback_arr)
int feedback_arr[NUM_JOINTS]; // Array that is updated on Arduino

int led = 13;

int feedbackCounter = 0;
int spinCounter = 0;
bool timerSetup = false;


// Creation of stepper array allows iteration through steppers
// Stepper(step_pin, dir_pin)
Stepper steppers[] = {Stepper(11, 10, true), Stepper(0, 0), Stepper(9, 8, true), Stepper(7, 6, true), Stepper(5, 4), Stepper(3, 2)};

// Allows calling array element with stepper name
// EX: steppers[J1]
// AR3 J2 is not controlled by Arduino
enum Stepper_name {J1, J2, J3, J4, J5, J6};

void setupTimer() {
  // Call timerCallBack ever TIMER_INTERVAL micro seconds
  Timer1.initialize(TIMER_INTERVAL);
  Timer1.attachInterrupt(timerCallBack);
  timerSetup = true;
}

void rosCmdCallback(const std_msgs::Int16MultiArray &msg) {
  // Cannot setup timer until connected
  if (!timerSetup) {
    setupTimer();
  }
  // Should implement speed control here
  
  // Set control setpoint
  
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].set_point(msg.data[i]);
  }
  
}



ros::Publisher feedback_pub("encoder_feedback", &feedback_multiArr);
ros::Subscriber<std_msgs::Int16MultiArray> step_sub("stepper_step", &rosCmdCallback);

void sendFeedback() {
  for (int i = 0; i < NUM_JOINTS; i++) {
    feedback_arr[i] = steppers[i].get_current_step();
  }
  feedback_pub.publish(&feedback_multiArr);
}


void setup() {
  feedback_multiArr.data_length = NUM_JOINTS;
  feedback_multiArr.data = feedback_arr;

  nh.getHardware()->setBaud(BAUD_RATE);
  nh.initNode();
  nh.subscribe(step_sub);
  nh.advertise(feedback_pub);

  // Setup Steppers
  steppers[J1].set_speed(5, 30);
  // J2 is controlled by diablo
  steppers[J3].set_speed(5, 30);
  steppers[J4].set_speed(5, 30);
  steppers[J5].set_speed(5, 40);
  steppers[J6].set_speed(5, 35);

  pinMode(led, OUTPUT);
  digitalWrite(led, HIGH);

 
    
}

void loop() {
  
  if (spinCounter > SPIN_RATE) {
    nh.spinOnce();
    spinCounter = 0;
  } else {
    if (!timerSetup) {
      spinCounter++;
    }
    
  }
  
  
  
  if (feedbackCounter > FEEDBACK_RATE) {
      sendFeedback();
      feedbackCounter = 0;
  }
  
}

// Needs to be quick to ensure function is not running when next interrupt occurs.
void timerCallBack() {
    digitalWrite(led, LOW);
    for (int i = 0; i < NUM_JOINTS -1; i++) {
      steppers[i].step();
    }

    feedbackCounter++;
    spinCounter++;

    digitalWrite(led, HIGH);
}
