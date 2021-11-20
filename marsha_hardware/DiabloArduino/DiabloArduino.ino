// This is a basic example of what the Diablo can do
// The test goes from full reverse to full forward and back again in a smooth ramp
// After each setting the system checks the EPO state (the optional switch) and the motor speeds
//
// At a regular point in the loop and before talking to the Diablo for the first time we check if we can
// see the board properly by asking it to report an ID number, if not the LED on the Arduino will flash
// until it can see the board.
// 
// If the motor speeds are not as expected the LED on the Arduino is turned on
// If the EPO is tripped it should prevent the motors running causing the LED to come on
// Restarting the Arduino will reset the EPO latch, you will need to ensure the EPO switch is no longer set
// first though (e.g. put the jumper back on), otherwise the EPO will immediately trip and latch again
//
// Finally the communications failsafe is enabled, this means if the Diablo does not hear from the
// Arduino for more than 1/4 of a second it will stop the motors until it is talked to again
// This can be tested by disconnecting either SDA or SCL without disconnecting the 3.3v or GND pins,
// or by running a different example which does not talk to the Diablo
// It will also activate when programming the Arduino (since this holds the Arduino in reset)
//
// The pins on one of the Diablo six-pin headers need to be connected as follows:
// Pin 1 -> Unused      May be left disconnected, it is marked with a 1
// Pin 2 -> Unused      May be left disconnected
// Pin 3 -> SDA         I2C data line, used for communications
// Pin 4 -> 5v          Power for the PIC, otherwise known as 5V
// Pin 5 -> SCL         I2C clock line, used for communications
// Pin 6 -> GND         Ground, otherwise known as 0v, reference for all other lines
//
// The pins are arranged:
// 1: Unused  2: Unused
// 3: SDA     4: 5v
// 5: SCL     6: GND
//
// The SDA and SCL connections vary between Arduinos and may not be clearly marked,
// refer to the table below
// Board            SDA     SCL
// -----------------------------
// Uno              A4      A5
// Ethernet         A4      A5
// Mega2560         20      21
// Leonardo         2       3
// Due              SDA1    SCL1
////

// If the LED on the Arduino will not stop flashing check the Diablo is connected properly (pins as
// listed above), also check the Diablo is powered properly (it needs 5v and GND to be connected)
// If you are connected and powered but you still cannot get the example to work then uncomment line 75 to
// get the example to scan the I2C bus for the boards address itself, this makes the code slightly larger but
// allows a single board attached to work with any set address
// See DiabloSetNewAddress if you wish to change the I2C address used by the Diablo
// If you do change the I2C address change line 75 to set the new address, if using 0x10 for example:
//     diabloAddress = 0x10;
// This way you may also connect multiple Diablos by daisy-chaining them after giving each a unique
// address, simply set the required address to diabloAddress before calling a Diablo* function to talk to the required
// board
//
// This example has a binary sketch size of 3,770 bytes when compiled for an Arduino Uno


//#include "DiabloStepper.h"
#include "Diablo.h"
#include <Wire.h>

int led = 13;




void setup()
{
    Serial.begin(9600);
    Serial.println("Setting up stepper...");
    //stepper = DiabloStepper();
    Serial.println("Stepper setup");
    //DiabloStepper stepper;
    diabloAddress = DiabloScanForAddress(0);

    //while (stepper.error_check()) {
    //    Serial.println("Error!");
    //    delay(1000);                 // Delay for a 1/4 second
    //}
    Serial.println("No Error!");
    //stepper.set_dir(1);
    //stepper.move_step(100);
}


void loop() {

    
    // Check we can see the Diablo
    //if (stepper.error_check()) {
    Serial.println("Error in loop!");
    //}


}
