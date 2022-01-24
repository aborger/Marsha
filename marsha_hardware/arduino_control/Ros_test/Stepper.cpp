#include "Stepper.h"

// Static variables
Stepper* Stepper::steppers;
int Stepper::num_steppers;

// ======================== Stepper with Encoder ==============================
// Not using inheritance because of the static array of steppers.
Stepper::Stepper(int _step_pin, int _dir_pin, int enc_pinA, int enc_pinB) {

  encoder = new Encoder(enc_pinA, enc_pinB);
  encoder_enabled = true;
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin, int enc_pinA, int enc_pinB, bool flip_direction) {
  pos_dir = flip_direction;
  encoder = new Encoder(enc_pinA, enc_pinB);
  encoder_enabled = true;
  init(_step_pin, _dir_pin);
}

void Stepper::step_w_encoder() {
  current_step = encoder->read();
  
  if (digitalRead(step_pin) == HIGH && timer > on_time) {
    digitalWrite(step_pin, LOW);
    timer = 0;
  }
  else {
    if (timer > off_time) {
      if (current_step < desired_step) {
        digitalWrite(dir_pin, pos_dir);
        digitalWrite(step_pin, HIGH);
        current_dir = true;
      } else if (current_step > desired_step) {
        digitalWrite(dir_pin, !pos_dir);
        digitalWrite(step_pin, HIGH);
      }
      timer = 0;
    } else {
      timer++;
    }
  }
}
// ======================= Stepper =========================================
// Stepper without encoder
Stepper::Stepper(int _step_pin, int _dir_pin) {
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin, bool flip_direction) {
  pos_dir = flip_direction;
  init(_step_pin, _dir_pin);
}

void Stepper::init(int _step_pin, int _dir_pin) {
  step_pin = _step_pin;
  dir_pin = _dir_pin;

  // In degrees
  current_step = 0;
  desired_step = 0;
  timer = 0;

  current_dir = true;

  // defaults
  on_time = 1;
  off_time = DELAY;

  pinMode(step_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);
}

void Stepper::set_speed(int _on_time, int _off_time) {
  on_time = _on_time;
  off_time = _off_time;
}
void Stepper::set_speed(int velocity_percent) {
  int max_delay = 200;
  int min_delay = 5;

  off_time = (int)map(velocity_percent, 0, 100, max_delay, min_delay);
  if (off_time > max_delay) {
    off_time = max_delay;
  }
  if (off_time < min_delay) {
    off_time = min_delay;
  }
}

int Stepper::get_speed() {
  return off_time;
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

void Stepper::velPID() {
  int error = abs(desired_step - current_step);
  set_speed((int)P_val * error);
}

void Stepper::step() {
  velPID();
  if (encoder_enabled) {
    step_w_encoder();
  }
  else {
    
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
}

//void Stepper::acc_step() {
//  steppers[0].set_speed
//}


void Stepper::set_point(int step_position) {
  digitalWrite(13, HIGH);
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
void Stepper::timerCallBack() {
  for(int i=0; i < num_steppers; i++) {
    steppers[i].step();
  }
}
void Stepper::setSteppers(Stepper* _steppers, int _num_steppers) {
  steppers = _steppers;
  num_steppers = _num_steppers;
  Timer1.initialize(TIMER_INTERVAL);
  Timer1.attachInterrupt(timerCallBack);
}
