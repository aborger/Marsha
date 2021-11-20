#include "Arduino.h"
#include "DiabloStepper.h"

DiabloStepper::DiabloStepper() {
  
  Wire.begin();
  error = false;
  
  diabloAddress = DiabloScanForAddress(0);
  //error = !DiabloCheckId();
  //DiabloResetEpo();

  // Enabling diablo turning motors off if communication fails
  //while (!DiabloGetCommsFailsafe()) {
  //  DiabloSetCommsFailsafe(true);
  //}

  // Set stepper characteristics
  //voltageOut = STEPPER_CURRENT * STEPPER_RESISTANCE;
  //stepperPower = voltageOut / VOLTAGE_IN;
  //maxPower = DRIVE_LEVEL * stepperPower;
  //holdingPower = HOLD_LEVEL * stepperPower;

  /* Order for stepping - Recreating matrix:
     [ +   + ]
     [ +   - ]
     { -   - ]
     [ -   + ]
  */
  /*
  // First make sequence matrix
  sequence[0][0] = 1;
  sequence[0][1] = 1;
  sequence[1][0] = 1;
  sequence[1][1] = -1;
  sequence[2][0] = -1;
  sequence[2][1] = -1;
  sequence[3][0] = -1;
  sequence[3][1] = 1;

  
  // Create max and holding sequences with respective powers
  for (int i = 0; i < 4; i++) {
    for (int j = 0; i < 2; i++) {
      max_sequence[i][j] = maxPower * sequence[i][j];
      holding_sequence[i][j] = holdingPower * sequence[i][j];
    }
  }
  */
}
/*
void DiabloStepper::move_step(int num_steps) {
  int sequence_step = 0;
  for (int i = 0; i < num_steps; i++) {
    DiabloSetMotor1(max_sequence[sequence_step][0]);
    DiabloSetMotor2(max_sequence[sequence_step][1]);

    // Increase step based on direction
    if (step_direction) {
      sequence_step += 1 ;
    } else {
      sequence_step -= 1;
    }

    // Wrap step to other side of array
    if (sequence_step > 3) {
      sequence_step = 0;
    }
    if (sequence_step < 0) {
      sequence_step = 3;
    }
    
    delayMicroseconds(STEP_DELAY);
  }
}

void DiabloStepper::set_dir(bool dir) {
  step_direction = dir;
}

bool DiabloStepper::error_check() {
  return error;
}
*/
