#ifndef Stepper_h
#define Stepper_h

#include "Arduino.h"
#include "TimerOne.h"
#include <Encoder.h>

#define TOLERANCE    10
#define TIMER_INTERVAL  10



#define MAX_ERROR_SUM   1000

#define STEPPER_POWER_PIN   23 // HIGH when steppers have power, allows encoder counting while off.



class Stepper {
  
  private:
    static void timerCallBack();

    
    
    int step_pin;
    int dir_pin;

    Encoder *encoder;
    bool encoder_enabled = false;

    
    int desired_step = 0;
    
    

    bool current_dir; // true if forward/dir_pin low

    bool pos_dir = false;

    int DELAY = 30;

    // Closed loop Controler
    float K_P = 1;      // Default: 1
    float K_I = 0.0001; // Default: 0.0001  If its stuck use slower speed for more torque

    float K_Pset = 1; // Higher value gets to set point quicker
    float K_P0 = 1; // Higher value starts moving slower
    int max_steps; // If the controller error is greater than this it will go max speed
    
    int max_delay = 60; // Delay that provides the most torque
    int min_delay = 5; // Fastest the joint can go
    
    int timer;

    int on_time;
    int off_time;

    int upper_bound;
    int lower_bound;

    volatile int enc_step = 0;
    volatile int current_step = 0;
    int init_step = 0;

    float enc_error;
    float error_sum = 0;

    int velocity_out;
  public:
   
    static Stepper* steppers;
    static int num_steppers;
    static void setSteppers(Stepper* _steppers, int _num_steppers);
    static bool stepper_power;

    Stepper(int _step_pin, int _dir_pin, int enc_pinA, int _enc_pinB);
    Stepper(int _step_pin, int _dir_pin, int enc_pinA, int _enc_pinB, bool flip_direction);
    Stepper(int _step_pin, int _dir_pin);
    Stepper(int _step_pin, int _dir_pin, bool flip_direction); 
    virtual void init(int _step_pin, int _dir_pin);
    
    
    void set_speed(int _on_time, int _off_time); // Note: not setting speed but rather delay time
    void set_speed(int velocity_percent); // Assumes default on_time
    int get_speed();
    int get_off_time();
    void set_bounds(int upper, int lower); // For testing without ros
    // old tune controller:
    // void tune_controller(float p, float i, int _min_delay, int _max_delay); // This could be part of the constructor
    void tune_controller(int _max_steps, float p_set, float p_0, int _min_delay, int _max_delay);
    
    void watch_bounds();
    void step();
    void step_w_encoder();

    void velPID();
    void openController();
    
    void set_point(int step_position);

    void update_step_cnt(); // Call when stepper power activates

    int get_enc_step();
    int get_desired_step();


    

};




#endif
