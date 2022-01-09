#include "Stepper.h"

Stepper::Stepper(int _step_pin, int _dir_pin, bool flip_direction=false) {
  step_pin = _step_pin;
  dir_pin = _dir_pin;

  pos_dir = flip_direction;

  // In degrees
  current_step = 0;
  desired_step = 0;
  timer = 0;

  current_dir = true;

  on_time = DELAY;
  off_time = DELAY;

  // defaults
  DELAY = 25;

  pinMode(step_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);

  
}

void Stepper::set_speed(int _on_time, int _off_time) {
  current_step = 0;
  desired_step = 0;

  on_time = _on_time;
  off_time = _off_time;
}

// For testing without ros
void Stepper::set_bounds(int upper, int lower) {
  upper_bound = upper;
  lower_bound = lower;
}

void Stepper::watch_bounds() {
  if (get_current_step() > upper_bound) {
    set_point(lower_bound - 1);
  }
  if (get_current_step() < lower_bound) {
    set_point(upper_bound + 1);
  }
}
/*
// num_steps is never higher than STEP_SIZE
void Stepper::step(int num_steps) {
  bool dir = true;
  if (num_steps < 0) {
    dir = false;
    digitalWrite(dir_pin, HIGH);
    num_steps *= -1;
  }
  for(int i=0; i<num_steps; i++) {
    for (int j = 0; j < STEP_SIZE; j++) {
    // take a step
      digitalWrite(step_pin, HIGH);
      delayMicroseconds(DELAY);
      digitalWrite(step_pin, LOW);
      delayMicroseconds(DELAY);
    }

    // update current step
    if (dir) {
      current_step += 1;
    }
    else {
      current_step -= 1;
    }
  }
  digitalWrite(dir_pin, LOW);
}
*/
void Stepper::step() {
  if (digitalRead(step_pin) == HIGH && timer > on_time) {
    digitalWrite(step_pin, LOW);
    timer = 0;
  }
  else {
    if (timer > off_time) {
      if (current_step > desired_step - TOLERANCE && current_step < desired_step + TOLERANCE) {}
      else {
        if (current_dir) {
          // Go forwards
          current_step += 1;
        }
        else {
          current_step -= 1;
        }
        digitalWrite(step_pin, HIGH);
      }
      timer = 0;
    }
    else {
      timer++;
    }
  }
}

void Stepper::single_step(bool dir) {
  digitalWrite(dir_pin, dir);
  digitalWrite(step_pin, HIGH);
  delayMicroseconds(DELAY);
  digitalWrite(step_pin, LOW);
  delayMicroseconds(DELAY);
}

void Stepper::control_step_pos() {
  long int step_error = desired_step - current_step;

  // step by 100
  if (step_error > STEP_PER_CALL) {
    step(STEP_PER_CALL);
  }
  else{
   step(step_error);
  }
}


void Stepper::set_point(int step_position) {
  desired_step = step_position;
  if (current_step < desired_step) {
    digitalWrite(dir_pin, pos_dir);
    current_dir = true;
  }
  else {
    digitalWrite(dir_pin, !pos_dir);
    current_dir = false;
  }
}

int Stepper::get_current_step() {
  return current_step;
}
int Stepper::get_desired_step() {
  return desired_step;
}
