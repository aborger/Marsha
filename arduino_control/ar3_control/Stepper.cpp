#include "Stepper.h"

// Static variables
Stepper* Stepper::steppers;
int Stepper::num_steppers;
bool Stepper::stepper_power;
bool Stepper::calibrated;

/* ========================================================== */
/*               Construct Stepper With Encoder               */
/* ========================================================== */
// Not using inheritance because of the static array of steppers.
Stepper::Stepper(int _step_pin, int _dir_pin, int enc_pinA, int enc_pinB, int _limit_pin) {
  init_limit(_limit_pin);
  encoder = new Encoder(enc_pinA, enc_pinB);
  encoder_enabled = true;
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin, int enc_pinA, int enc_pinB, int _limit_pin, bool flip_direction) {
  init_limit(_limit_pin);
  pos_dir = flip_direction;
  encoder = new Encoder(enc_pinA, enc_pinB);
  encoder_enabled = true;
  init(_step_pin, _dir_pin);
}
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
  enc_step = int(encoder->read());///1.25); // 1 Step = 1.25 encoder steps
  
  if (digitalRead(step_pin) == HIGH && timer > on_time) {
    digitalWrite(step_pin, LOW);
    timer = 0;
  }
  else {
    if (timer > off_time) {
      // Tolerance is necessary because encoder steps are smaller so the perfect enc step may never be reached
      if (enc_step < desired_step - TOLERANCE) {
        digitalWrite(dir_pin, pos_dir);
        digitalWrite(step_pin, HIGH);
        if (stepper_power && current_step < desired_step) {
          current_step += 1;
        }
        current_dir = true;
      } else if (enc_step > desired_step + TOLERANCE) {
        digitalWrite(dir_pin, !pos_dir);
        digitalWrite(step_pin, HIGH);
        if (stepper_power && current_step < desired_step) {
          current_step -= 1;
        }
      }
      else {
        //current_step = enc_step;
        error_sum = 0;
      }
      timer = 0;
    } else {
      timer++;
    }
  }
}
/* ============================================================= */
/*               Construct Stepper Without Encoder               */
/* ============================================================= */
// Stepper without encoder
Stepper::Stepper(int _step_pin, int _dir_pin, int _limit_pin) {
  init_limit(_limit_pin);
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin, int _limit_pin, bool flip_direction) {
  init_limit(_limit_pin);
  pos_dir = flip_direction;
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin) {
  init(_step_pin, _dir_pin);
}
Stepper::Stepper(int _step_pin, int _dir_pin, bool flip_direction) {
  pos_dir = flip_direction;
  init(_step_pin, _dir_pin);
}

/* ========================================================== */
/*                                Setup                       */
/* ========================================================== */
void Stepper::init_limit(int _limit_pin) {
  limit_pin = _limit_pin;
  pinMode(limit_pin, INPUT_PULLUP);
}

bool Stepper::is_calibrated() {
  return calibrated;
}
void Stepper::calibrate(int* limit_positions) {
  Stepper::calibrated = true;
  digitalWrite(13, HIGH);
  for(int i=0; i < num_steppers; i++) {
    steppers[i].calibrate_stepper(limit_positions[i]);
  }

}
void Stepper::calibrate_stepper(int limit_position) {
  desired_step = limit_position;
  current_step = limit_position;
  
}
void Stepper::init(int _step_pin, int _dir_pin) {
  step_pin = _step_pin;
  dir_pin = _dir_pin;

  // In degrees
  current_step = 0;
  desired_step = 0;
  timer = 0;

  current_dir = true;
  stepper_power = false;

  // defaults
  on_time = 1;
  off_time = DELAY;

  pinMode(step_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);

}

/* ========================================================== */
/*                                Speed                       */
/* ========================================================== */
void Stepper::set_speed(int _on_time, int _off_time) {
  on_time = _on_time;
  off_time = _off_time;
}
void Stepper::set_speed(int velocity_percent) {


  off_time = (int)map(velocity_percent, 0, 100, max_delay, min_delay);
  if (off_time > max_delay) {
    off_time = max_delay;
  }
  if (off_time < min_delay) {
    off_time = min_delay;
  }
}

int Stepper::get_speed() {
  return velocity_out;
}

int Stepper::get_off_time() {
  return off_time;
}




// For testing without ros
void Stepper::set_bounds(int upper, int lower) {
  upper_bound = upper;
  lower_bound = lower;
}

void Stepper::watch_bounds() {
  if (get_enc_step() > upper_bound) {
    set_point(lower_bound - 1);
  }
  if (get_enc_step() < lower_bound) {
    set_point(upper_bound + 1);
  }
}

void Stepper::tune_controller(int _max_steps, float p_set, float p_0, int _min_delay, int _max_delay) {
  max_steps = _max_steps;
  K_Pset = p_set;
  K_P0 = p_0;
  min_delay = _min_delay;
  max_delay = _max_delay;
}

void Stepper::velPID() {
  int error = abs(desired_step - enc_step);
  enc_error = K_I*abs(current_step - enc_step);
  error_sum += enc_error;
  if (error_sum > MAX_ERROR_SUM) {
    error_sum = MAX_ERROR_SUM;
  }
  velocity_out = (int)(K_P*error - error_sum);
  if (velocity_out < 0) {
    velocity_out = 0;
  }
  
  set_speed(velocity_out);
}

void Stepper::openController() {
  int error = abs(desired_step - current_step);
  int init_dist = int(max_steps / abs(current_step -  init_step));
  //int v_out = int(100 / (1 + pow(EULER, (5 - error/100))));
  int v_out = map(K_Pset*error - K_P0*init_dist, 0, max_steps, 0, 100);
  
  set_speed(v_out);
  
}

void Stepper::step() {
  if (encoder_enabled) {
    velPID();
    step_w_encoder();
  }
  else {
    openController();
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
            enc_step += 1;
          }
          else {
            current_step -= 1;
            enc_step -= 1;
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

void Stepper::test_step() {
  desired_step = current_step + 20; // make it always move
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
          enc_step += 1;
        }
        else {
          current_step -= 1;
          enc_step -= 1;
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

//void Stepper::acc_step() {
//  steppers[0].set_speed
//}


void Stepper::set_point(int step_position) {
  init_step = step_position;
  desired_step = step_position;
  if (current_step < desired_step - TOLERANCE*2) {
    digitalWrite(dir_pin, pos_dir);
    current_dir = true;
  }
  else {
    digitalWrite(dir_pin, !pos_dir);
    current_dir = false;
  }
  
}

int Stepper::get_enc_step() {
  return enc_step;
}

int Stepper::get_curr_step() {
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

// To be called when stepper power activates
void Stepper::update_step_cnt() {
  current_step = enc_step;
}
