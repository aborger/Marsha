#ifndef Stepper_h
#define Stepper_h

#include "Arduino.h"
#include <ros.h>
#include <std_msgs/Float64.h>

#define TOLERANCE    1
#define STEP_PER_CALL    10
#define STEP_SIZE       10

class Stepper {
  private:
    int step_pin;
    int dir_pin;
    long int current_step = 0;
    long int desired_step = 0;

    int DELAY;
  public:
    Stepper(int _step_pin, int _dir_pin);
    void init(int step_delay);
    void step(int num_steps);
    void step();
    void set_point(long int step_position);
    void control_step_pos();

    long int get_current_step();
    long int get_desired_step();

  
};

#endif
