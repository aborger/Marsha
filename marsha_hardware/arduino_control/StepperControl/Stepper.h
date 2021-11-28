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
    int current_step = 0;
    int desired_step = 0;

    bool current_dir; // true if forward/dir_pin low

    bool pos_dir;

    int DELAY;
    int timer;

    int on_time;
    int off_time;

    int upper_bound;
    int lower_bound;
  public:
    Stepper(int _step_pin, int _dir_pin, bool flip_direction=false);
    void set_speed(int _on_time, int _off_time); // Note: not setting speed but rather delay time
    void set_bounds(int upper, int lower); // For testing without ros
    void watch_bounds();
    void step(int num_steps);
    void step();
    void set_point(int step_position);
    void control_step_pos();

    int get_current_step();
    int get_desired_step();

  
};

#endif
