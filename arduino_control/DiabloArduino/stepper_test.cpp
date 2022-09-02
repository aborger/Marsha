/*
* A test that rotates the stepper ~ 90 degrees in both directions
*
* Developed for Arduino, would need to be edited to work on Jetson Nano or RPI
*
* DELAY is directly correlated to speed, the motor runs slow so the delay should be
* decreased, however there is a point where if the delay is to small(i.e DELAY=1)
* the stepper doesn't move.
*/

#define DELAY       25

const int STEP_SIZE = DELAY * 1000;

int stepPin = 2;
int dirPin = 3;
int led = 13;


void forward_step() {
   for(int i=0; i<STEP_SIZE; i++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(DELAY);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(DELAY);
  }
}

void back_step() {
  digitalWrite(dirPin, HIGH);
  forward_step();
  digitalWrite(dirPin, LOW);
}

void setup() {
  pinMode(stepPin, OUTPUT);
  pinMode(led, OUTPUT);
  pinMode(dirPin, OUTPUT);

}

void loop() {
  digitalWrite(led, HIGH);
  forward_step();
  digitalWrite(led, LOW);
  delay(1000);
  back_step();
  delay(1000);
}