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
int inChar = 0;
String inString;


void forward_step(int step_val) {
  Serial.println("Forward step");
   for(int i=0; i<step_val * 1000; i++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(DELAY);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(DELAY);
  }
}

void back_step() {
  digitalWrite(dirPin, HIGH);
  //forward_step();
  digitalWrite(dirPin, LOW);
}

void setup() {
  pinMode(stepPin, OUTPUT);
  pinMode(led, OUTPUT);
  pinMode(dirPin, OUTPUT);
  Serial.begin(9600);

}

void loop() {
  if (Serial.available() > 0) {
    inChar = Serial.read();
    if (isDigit(inChar)) {
      inString += (char)inChar;
    }

    if (inChar == '\n') {
      int step_val = inString.toInt();
      Serial.println("Moving...");
      forward_step(step_val);
      inString = "";
    }
  }
}
