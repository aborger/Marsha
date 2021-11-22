int led = 13;

#include <ros.h>
#include <std_msgs/Empty.h>

ros::NodeHandle nh;


void messageCallBack(const std_msgs::Empty &toggle_msg) {
  digitalWrite(led, HIGH-digitalRead(led));
}

ros::Subscriber<std_msgs::Empty> sub("toggle_led", &messageCallBack);

void setup() {
  pinMode(led, OUTPUT);
  nh.initNode();
  nh.subscribe(sub);
}

void loop() {
  nh.spinOnce();
  delay(1);
  
}
