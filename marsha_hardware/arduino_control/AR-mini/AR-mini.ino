
#include "Stepper.h"



Stepper stepper = Stepper(3, 2);

void setup() {
  stepper.set_speed(5, 30);
  
}

void loop() {
  stepper.step(1000);
  delay(1000);

}
