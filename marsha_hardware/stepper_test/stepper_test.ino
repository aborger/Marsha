#include "Stepper.h"


int led = 13;

Stepper j1_stepper(2, 3);

String inString = "";


void setup() {
  Serial.begin(9600);

  
  pinMode(led, OUTPUT);
  Serial.println("Beginning Control...");

}

void loop() {
  while (Serial.available() > 0) {
    char inChar = Serial.read();
    inString += (char)inChar;
    
    if (inChar == '\n') {
      Serial.print("Value:");
      int step_size = inString.toInt();
      Serial.println(step_size);
      j1_stepper.step(step_size);
      
      inString = "";
    }
  }

}
