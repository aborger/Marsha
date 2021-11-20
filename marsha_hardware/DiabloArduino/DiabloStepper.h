#ifndef DiabloStepper_h
#define DiabloStepper_h

#include "Diablo.h"
#include <Wire.h>
#include "Arduino.h"

#define VOLTAGE_IN            12
#define STEPPER_CURRENT       2.8
#define STEPPER_RESISTANCE    0.9

#define DRIVE_LEVEL           1.0
#define HOLD_LEVEL            0.0

#define STEP_DELAY                 25


class DiabloStepper 
{
  public:
    DiabloStepper(); 


    void move_step(int num_steps);

    void set_dir(bool dir);

    bool error_check();
    
  private:

    bool step_direction;
  
    bool error;
    float voltageOut;
    float stepperPower;
    float maxPower;
    float holdingPower;

    int sequence[4][2];
    float max_sequence[4][2];
    float holding_sequence[4][2];


    
  
};

#endif
