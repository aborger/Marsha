#include <ros.h>
#include <std_msgs/Int16.h>

#define BAUD_RATE       115200
#define SPIN_RATE       500
#define FEEDBACK_RATE   10000


int spinCounter = 0;
int feedbackCounter = 0;


ros::NodeHandle nh;
std_msgs::Int16 feedback_msg;
int* feedback;


void rosVELCallback(const std_msgs::Int16 &msg) {
  steppers[3].set_speed(msg.data);
}

void rosCMDCallback(const std_msgs::Int16 &msg) {
  steppers[3].set_point(msg.data);

}

ros::Publisher feedback_pub("enc_feedback", &feedback_msg);
ros::Subscriber<std_msgs::Int16> cmd_sub("cmd", &rosCMDCallback);
ros::Subscriber<std_msgs::Int16> vel_sub("vel", &rosVELCallback);

void sendFeedback() {
  feedback_msg.data = *feedback;
  feedback_pub.publish(&feedback_msg);
}

void setup_ros(int* _feedback) {
  nh.getHardware()->setBaud(BAUD_RATE);
  nh.initNode();
  nh.subscribe(cmd_sub);
  nh.subscribe(vel_sub);
  nh.advertise(feedback_pub);
  feedback = _feedback;
}


void spin_ros() {
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
