
#include "Stepper.h"
#include "Comm.h"

#define BAUD_RATE     115200

#define SPIN_RATE     100
#define FEEDBACK_RATE 100000
#define NUM_JOINTS    4



Stepper steppers[] = {Stepper(23, 22), Stepper(21, 20), Stepper(36, 35), Stepper(34, 33)};

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

  // Note: these are tuned for a Teensy 3.5 at 120 MHz clock speed
  steppers[0].tune_controller(1, 0, 75, 100);
  steppers[1].tune_controller(1, 0, 75, 100);
  steppers[2].tune_controller(1, 0, 75, 100);
  steppers[3].tune_controller(1, 0, 100, 120); // 0, 1500 range

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
