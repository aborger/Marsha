
#include "Stepper.h"
#include "TimerOne.h"

#define TIMER_INTERVAL  50

int led = 13;


Stepper stepper = Stepper(9, 8);

void setupTimer() {
  // Call timerCallBack ever TIMER_INTERVAL micro seconds
  Timer1.initialize(TIMER_INTERVAL);
  Timer1.attachInterrupt(timerCallBack);
}

void setup() {
  stepper.set_speed(5, 40);
  setupTimer();
  pinMode(led, OUTPUT);
}

void loop() {
  stepper.set_point(2000);
  digitalWrite(led, HIGH);
  delay(5000);
  digitalWrite(led, LOW);
  stepper.set_point(0);
  delay(5000);

}


void timerCallBack() {
    stepper.step();



}
