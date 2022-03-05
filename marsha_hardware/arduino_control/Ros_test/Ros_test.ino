

#include "Stepper.h"
#include "Comm.h"

#define BAUD_RATE       115200

#define SPIN_RATE       100
#define FEEDBACK_RATE   1000000
#define NUM_JOINTS      6

#define NUM_INFO        3
#define DEBUG_STEPPER    3


// Note: It should attempt to stay at zero when turned on, if it continuously spins in one direction, flip the direction
//Stepper steppers[] = {Stepper(33, 34, 35, 22), Stepper(32, 31, 5, 4, true), Stepper(30, 29, 17, 18, true), Stepper(28, 27, 15, 16), Stepper(12, 11, 40, 41), Stepper(26, 25)};
Stepper steppers[] = {Stepper(23,22), Stepper(37,38), Stepper(35,36), Stepper(33,34)};

int led = 13;
int spinCounter = 0;
int feedbackCounter = 0;


Comm comm_handle;


void CMDCallback(RxPacket &rx) {
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].set_point(rx.step_cmd[i]);
  }
}



void sendFeedback() {
  int feedback_arr[NUM_JOINTS];
  for (int i = 0; i < NUM_JOINTS; i++) {
    feedback_arr[i] = steppers[i].get_enc_step();
  }
  TxPacket tx(feedback_arr, NUM_JOINTS);

  tx.doc["curr_step"] = steppers[DEBUG_STEPPER].current_step;
  tx.doc["curr_speed"] = steppers[DEBUG_STEPPER].get_speed();
  tx.doc["err_sum"] = steppers[DEBUG_STEPPER].error_sum;
  
  comm_handle.transmit(tx);
}


void stepper_power_callback() {
  Stepper::stepper_power = digitalRead(STEPPER_POWER_PIN);
  digitalWrite(13, Stepper::stepper_power);
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].update_step_cnt();
  }
}

void setup() {
  pinMode(led, OUTPUT);

  comm_handle.set_callback(CMDCallback);


  steppers[0].tune_controller(0.6, 0.00001, 20, 175);
  steppers[1].tune_controller(0.6, 0.00001, 40, 75);
  steppers[2].tune_controller(0.6, 0.00001, 20, 40);
  steppers[3].tune_controller(0.6, 0.00001, 10, 150);
  steppers[4].tune_controller(0.6, 0.00001, 10, 150);

  Stepper::setSteppers(steppers, 6);

  // Interrupt sets stepper_power to current power state on change
  attachInterrupt(STEPPER_POWER_PIN, stepper_power_callback, CHANGE);
}

void loop() {
  // put your main code here, to run repeatedly:
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
