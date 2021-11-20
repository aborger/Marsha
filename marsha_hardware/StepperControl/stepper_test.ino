#include "Stepper.h"


int led = 13;
int joint_number = 0;

Stepper stepper_array[] = {Stepper(2, 3), Stepper(4, 5)};

String inString = "";


void setup() {
  Serial.begin(9600);
  Serial.println("Setting up steppers...");
  
  pinMode(led, OUTPUT);
  Serial.println("Beginning Control...");

}

void loop() {
  while (Serial.available() > 0) {
    char inChar = Serial.read();
    inString += (char)inChar;

    // Run command on new line character
    if (inChar == '\n') {
      Serial.print("Joint: ");
      Serial.print(joint_number);
      int step_size = inString.toInt();
      Serial.print(" steps: ");
      Serial.println(step_size);
      stepper_array[joint_number].step(step_size - 1);
      
      inString = "";
    }

    // If underscore save the joint number
    if (inChar == ' ') {
      joint_number = inString.toInt();
      inString = "";
    }
  }

}
