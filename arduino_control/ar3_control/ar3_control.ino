
#include "Stepper.h"
#include "Comm.h"

#define BAUD_RATE     115200

#define SPIN_RATE     100
#define FEEDBACK_RATE 300000
#define NUM_JOINTS    6


// Encoder & Limit: Stepper(x, x, x, x, x, t/f);
// Encoder:         Stepper(x, x, x, x, t/f);
// Limit:           Stepper(x, x, x, t/f);
// Stepper only:    Stepper(x, x, t/f);
Stepper steppers[] = {Stepper(33, 37), Stepper(38, 39), Stepper(40, 41), Stepper(27, 28), Stepper(29, 30), Stepper(31, 32)};

int spinCounter = 0;
int feedbackCounter = 0;

Comm comm_handle;


void CMDCallback(RxPacket &rx) {
  if (rx.calibrate || !Stepper::is_calibrated()) {
    Stepper::calibrate(rx.step_cmd);
  } else {
    for (int i = 0; i < NUM_JOINTS; i++) {
      steppers[i].set_point(rx.step_cmd[i]);
    }
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
  
  // tune_controller(int _max_steps, float p_set, float p_0, int _min_delay, int _max_delay)
  // calculate max steps by dividing appropriate degree by stepper's deg_per_step value
  steppers[0].tune_controller(16000, 10, 20, 5, 100);
  steppers[1].tune_controller(5000, 5, 50, 20, 200);
  steppers[2].tune_controller(5000, 5, 20, 10, 200);
  steppers[3].tune_controller(8223, 10, 20, 50, 80);
  steppers[4].tune_controller(333, 1, 0, 90, 100);
  steppers[5].tune_controller(100, 10, 5, 10, 11);
  //steppers[5].set_speed(10, 25);

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
