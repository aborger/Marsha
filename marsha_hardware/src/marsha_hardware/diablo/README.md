[![PiBorg's Diablo](diablo_banner.png)](https://piborg.org/diablo)

The [Diablo](https://www.piborg.org/diablo) is a dual channel motor controller for use with the Raspberry Pi, Arduino and other I2C capable SBCs.

It can be used with motors or steppers from 7V to 36V and is current limited to 55A per channel. Speed control is via PWM via I2C and the board has overheat protection, under voltage lockout and short circuit protection.

Shop: [Diablo](https://www.piborg.org/diablo)

# Quick Start Guide
Our complete [Quick Start Guide](https://www.piborg.org/blog/diablo-quick-start-guide) will show you how to use the ```diabloGui.py``` and a one motor setup with a Raspberry Pi and Diablo.

# Install this Library
```
git clone https://github.com/piborg/diablo
cd diablo
bash install.sh
```
This will install the Diablo library, the PiBorg Motor GUI and all dependencies needed to run the set of examples contained here.

# Diablo Library
```diablo.py``` contains the Diablo library with lots of functions describing how to use the Diablo. For a full breakdown of the API available please see the [Diablo API](http://forum.piborg.org/diablo/examples#api).

# Examples
There are several examples in this repository to give you an idea of how to use the library with hardware.

## ```diabloGui.py```
Control a motor using Diablo and a GUI with a slider bar. The setup for this example is explained in our [Quick Start Guide](https://www.piborg.org/blog/diablo-quick-start-guide).

## ```diabloJoystick.py```
Control a motor using Diablo, a PS4 controller and [Pygame](https://www.pygame.org/).

## ```diabloSequence.py```
Driving two motors at a sequence of speeds using a Diablo. Full tutorial is [available on our website](https://www.piborg.org/blog/build/diablo-build/diablo-motor-sequence-example).

## ```diabloStepper.py```
Driving a 4 wire stepper motor using a Diablo. Follow the [full tutorial on our site](https://www.piborg.org/blog/build/diablo-build/diablo-stepper-example).

## ```diabloStepperSeq.py```
Driving a 4 wire stepper motor using a sequnce of movements via a Diablo. Follow the [full tutorial on our site](https://www.piborg.org/blog/build/diablo-build/diablo-stepper-example).

# Troubleshooting
For troubleshooting with the Diablo please refer to our [troubleshooting pages](https://www.piborg.org/blog/diablo-troubleshooting) and for further help please post questions on our [forum](http://forum.piborg.org/forum/diablo).

# Reporting Issues

If you find a bug with the Diablo code, please feel free to report it as an issue. When reporting issues with this library please fill in the issue report with as much information as you can to help us help you.

Please supply as much information as you can so we can replicate the bug locally. :)
