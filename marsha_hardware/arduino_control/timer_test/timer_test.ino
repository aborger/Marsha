/*
This program turns on and off a LED on pin 13 each 1 second using an internal timer
*/
#include "Stepper.h"
#include "TimerOne.h"
/*
void set_50us_timer() {
  TCCR0A=(1<<WGM01);    //Set the CTC mode   
  OCR0A=0x01; //Value for ORC0A for 50 us
  
  TIMSK0|=(1<<OCIE0A);   //Set the interrupt request
  sei(); //Enable interrupt
  
  TCCR0B|=(1<<CS00);    // Set prescale 1/8 clock
  //TCCR0B|=(1<<CS01);
}
*/
Stepper j1 = Stepper(6, 7);
Stepper j3 = Stepper(4, 5);
Stepper j5 = Stepper(2, 3);


void setup() {
  pinMode(13,OUTPUT);

  j1.set_speed(5, 30);
  j1.set_bounds(3000, -3000);
  j1.set_point(-3001);

  j3.set_speed(5, 30);
  j3.set_bounds(1500, -1500);
  j3.set_point(3001);

  j5.set_speed(5, 40);
  j5.set_bounds(500, -500);
  j5.set_point(501);
    
  Timer1.initialize(50);
  Timer1.attachInterrupt(timerCallBack);

 
    
}

void loop() {

}

void timerCallBack() {
    j1.step();
    j3.step();
    j5.step();

    j1.watch_bounds();
    j3.watch_bounds();
    j5.watch_bounds();
}
/*
ISR(TIMER0_COMPA_vect){    //This is the interrupt request
    stepper.step();
    if (stepper.get_current_step() > 25000) {
      stepper.set_point(-36000);
    }
    if (stepper.get_current_step() < -30000) {
      stepper.set_point(29000);
    }
}
*/
