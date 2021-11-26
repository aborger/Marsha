#include "Stepper.h"

Stepper::Stepper(int _step_pin, int _dir_pin) {
  step_pin = _step_pin;
  dir_pin = _dir_pin;

  // In degrees
  current_step = 0;
  desired_step = 0;

  // defaults
  DELAY = 25;

  pinMode(step_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);

  
}

void Stepper::init(int step_delay) {
  DELAY = step_delay;
  current_step = 0;
  desired_step = 0;
}

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

void Stepper::step() {
  if (current_step > desired_step && current_step < desired_step) {}
  else {
    if (current_step < desired_step) {
      // Go forwards
      digitalWrite(dir_pin, LOW);
      current_step += 1;
    }
    else {
      digitalWrite(dir_pin, HIGH);
      current_step -= 1;
    }
    digitalWrite(step_pin, HIGH);
    delayMicroseconds(DELAY);
    digitalWrite(step_pin, LOW); 
  }
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


void Stepper::set_point(long int step_position) {
  desired_step = step_position;
}

long int Stepper::get_current_step() {
  return current_step;
}
long int Stepper::get_desired_step() {
  return desired_step;
}
