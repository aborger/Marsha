#include "Stepper.h"

Stepper::Stepper(int _step_pin, int _dir_pin) {
  step_pin = _step_pin;
  dir_pin = _dir_pin;

  pinMode(step_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);
}

void Stepper::step(int num_steps) {
  if (num_steps < 0) {
    digitalWrite(dir_pin, HIGH);
    num_steps *= -1;
  }
  for(int i=0; i<num_steps*1000; i++) {
    digitalWrite(step_pin, HIGH);
    delayMicroseconds(DELAY);
    digitalWrite(step_pin, LOW);
    delayMicroseconds(DELAY);
  }
  digitalWrite(dir_pin, LOW);
}
