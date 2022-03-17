
#include "Stepper.h"
#include "Comm.h"

#define BAUD_RATE     115200

#define SPIN_RATE     100
#define FEEDBACK_RATE 100000
#define NUM_JOINTS    5



Stepper steppers[] = {Stepper(33, 37), Stepper(38, 39), Stepper(40, 41), Stepper(2, 3), Stepper(4, 5)};// Stepper(30, 29, 38, 39)};

int spinCounter = 0;
int feedbackCounter = 0;

Comm comm_handle;

void CMDCallback(RxPacket &rx) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].set_point(rx.step_cmd[i]);
  }
}

void sendFeedback() {
  // Load array with feedback
  int feedback_arr[NUM_JOINTS];
  for (int i = 0; i < NUM_JOINTS; i++) {
    feedback_arr[i] = steppers[i].get_curr_step();
  }

  // Create packet for feedback
  TxPacket tx(feedback_arr, NUM_JOINTS);

  // An example for how to send extra debug data
  // tx.doc["extra_data"] = data

  comm_handle.transmit(tx);

}

void setup() {
  pinMode(13, OUTPUT);

  comm_handle.set_callback(CMDCallback);

  steppers[0].tune_controller(1, 0, 10, 15);
  steppers[1].tune_controller(1, 0, 30, 35);
  steppers[2].tune_controller(1, 0, 10, 15);
  steppers[3].tune_controller(1, 0, 10, 15);
  steppers[4].tune_controller(1, 0, 10, 15);

  Stepper::setSteppers(steppers, NUM_JOINTS);
  Stepper::stepper_power = true;
}

void loop() {
  if (spinCounter > SPIN_RATE) {

    comm_handle.spin();
    spinCounter = 0;
  }
  if (feedbackCounter > FEEDBACK_RATE) {
    sendFeedback();
    feedbackCounter = 0;
  }

  spinCounter++;
  feedbackCounter++;
}
