//

#include "Stepper.h"
#include "Comm.h"
#include "TimerOne.h"


#define SPIN_RATE       100
#define FEEDBACK_RATE   1000000
#define BLINK_RATE      1000000 //1000000
#define NUM_JOINTS      6

#define NUM_INFO        2
#define DEBUG_STEPPER    2


// Note: It should attempt to stay at zero when turned on, if it continuously spins in one direction, flip the direction
// Bread Board
//Stepper steppers[] = {Stepper(33, 34, 6, 7), Stepper(2, 3, 37, 38), Stepper(32, 31, 11, 12), Stepper(35, 36, 39, 40), Stepper(28, 27, 41, 14), Stepper(26, 25, 15, 16)};

// PCB
//Stepper steppers[] = {Stepper(25, 24, 23, 22), Stepper(29, 28, 21, 20), Stepper(33, 32, 18, 17), Stepper(35, 34, 5, 6), Stepper(37, 36, 16, 15), Stepper(31, 30, 41, 40)};
//Stepper steppers[] = {Stepper(25, 24, 22, 23, true), Stepper(29, 28, 21, 20), Stepper(33, 32, 18, 17), Stepper(35, 34, 5, 6), Stepper(37, 36, 15, 16), Stepper(31, 30, 41, 40)};
Stepper steppers[] = {Stepper(25, 24, 22, 23, true), Stepper(29, 28, 21, 20), Stepper(31, 30, 40, 41), Stepper(37, 36, 15, 16), Stepper(35, 34, 6, 5), Stepper(33, 32, 18, 17)};


// J6 tests
//Stepper steppers[] = {Stepper(25, 24, 23, 22), Stepper(29, 28, 21, 20), Stepper(33, 32, 18, 17), Stepper(37, 36, 6, 5, true), Stepper(35, 34, 16, 15, true), Stepper(31, 30, 41, 40)};

int led = 13;
int spinCounter = 0;
int feedbackCounter = 0;
int blinkCounter = 0;


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

  //tx.doc["curr_step"] = steppers[DEBUG_STEPPER].current_step;
  //tx.doc["curr_speed"] = steppers[DEBUG_STEPPER].get_speed();
  //tx.doc["err_sum"] = steppers[DEBUG_STEPPER].error_sum;
  
  comm_handle.transmit(tx);
}


void stepper_power_callback() {
  Stepper::stepper_power = digitalRead(STEPPER_POWER_PIN);
  //digitalWrite(13, Stepper::stepper_power);
  for (int i = 0; i < NUM_JOINTS; i++) {
    steppers[i].update_step_cnt();
  }
}

void setup() {
  pinMode(led, OUTPUT);

  comm_handle.set_callback(CMDCallback);

  // tune_controller(int _max_steps, float p_set, float p_0, int _min_delay, int _max_delay)
  // calculate max steps by dividing appropriate degree by stepper's deg_per_step value
  // to tune start with max_steps at half way to full range of motion and p_0 = 0, p_set=1
  // find good p_set, if it skips steps in beginning increase p_0
  steppers[0].tune_controller(5000, 0.5, 20, 100, 120);
  steppers[1].tune_controller(5000, 0.5, 20, 20, 100);
  steppers[2].tune_controller(5000, 0.75, 10, 20, 40);
  steppers[2].TOLERANCE = 20;
  steppers[3].tune_controller(600, 1, 50, 20, 100);
  steppers[4].tune_controller(750, 0.75, 20, 20, 100);
  steppers[5].tune_controller(500, 1, 0, 10, 100);

  Stepper::setSteppers(steppers, 6);

  // Interrupt sets stepper_power to current power state on change
  attachInterrupt(STEPPER_POWER_PIN, stepper_power_callback, CHANGE);
  //Timer1.initialize(10);
  //Timer1.attachInterrupt(timerCB);
  digitalWrite(led, HIGH);
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
  if (!comm_handle.connection_successful) {
    if (blinkCounter > BLINK_RATE) {
      digitalWrite(led, !digitalRead(led));
      blinkCounter = 0;
    }
  }
  
  

  spinCounter++;
  feedbackCounter++;
  blinkCounter++;
}

void timerCB() {

}
