#ifndef Stepper_h
#define Stepper_h

#include "Arduino.h"

#define DELAY       25

class Stepper {
  public:
    Stepper(int _step_pin, int _dir_pin);
    void step(int num_steps);
    void step_rad(float angle_rads);
  private:
    int step_pin;
    int dir_pin;
  
};

#endif
