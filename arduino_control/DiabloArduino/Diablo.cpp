/**************************/
/***** Diablo Library *****/
/**************************/

// Includes
#include <Wire.h>               // The I2C library
#include "Diablo.h"             // The Diablo library constants

// Parameters
byte diabloAddress = DIABLO_DEFAULT_I2C_ADDRESS;  // The I2C address we are currently talking to

// Private memory
byte rdBuffer[DIABLO_I2C_MAX_LEN];             // Buffer used for reading replies

// Private function used to read the reply to GET commands
// Overwrites the contents of rdBuffer
void ReadInReply(void) {
    int idx;
    Wire.requestFrom(diabloAddress, (byte)DIABLO_I2C_MAX_LEN);
    for (idx = 0; idx < DIABLO_I2C_MAX_LEN; ++idx) {
        if (Wire.available()) {
            rdBuffer[idx] = Wire.read();
        } else {
            rdBuffer[idx] = 0;
        }
    }
}

/***** Motor functions *****/

// Sets the drive level for motor 2
void DiabloSetMotor2(int power) {
    Wire.beginTransmission(diabloAddress);
    if (power < 0) {
        Wire.write(DIABLO_COMMAND_SET_A_REV);
        power = -power;
    } else {
        Wire.write(DIABLO_COMMAND_SET_A_FWD);
    }
    if (power > DIABLO_PWM_MAX) {
        Wire.write(DIABLO_PWM_MAX);
    } else {
        Wire.write((byte)power);
    }
    Wire.endTransmission();
}

// Gets the drive level for motor 2
int DiabloGetMotor2(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_A);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_FWD) {
        return (int)rdBuffer[2];
    } else if (rdBuffer[1] == DIABLO_COMMAND_VALUE_REV) {
        return -(int)rdBuffer[2];
    } else {
        return DIABLO_ERROR_READING;
    }
}

// Sets the drive level for motor 1
void DiabloSetMotor1(int power) {
    Wire.beginTransmission(diabloAddress);
    if (power < 0) {
        Wire.write(DIABLO_COMMAND_SET_B_REV);
        power = -power;
    } else {
        Wire.write(DIABLO_COMMAND_SET_B_FWD);
    }
    if (power > DIABLO_PWM_MAX) {
        Wire.write(DIABLO_PWM_MAX);
    } else {
        Wire.write((byte)power);
    }
    Wire.endTransmission();
}

// Gets the drive level for motor 1
int DiabloGetMotor1(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_B);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_FWD) {
        return (int)rdBuffer[2];
    } else if (rdBuffer[1] == DIABLO_COMMAND_VALUE_REV) {
        return -(int)rdBuffer[2];
    } else {
        return DIABLO_ERROR_READING;
    }
}

// Sets the drive level for all motors
void DiabloSetMotors(int power) {
    Wire.beginTransmission(diabloAddress);
    if (power < 0) {
        Wire.write(DIABLO_COMMAND_SET_ALL_REV);
        power = -power;
    } else {
        Wire.write(DIABLO_COMMAND_SET_ALL_FWD);
    }
    if (power > DIABLO_PWM_MAX) {
        Wire.write(DIABLO_PWM_MAX);
    } else {
        Wire.write((byte)power);
    }
    Wire.endTransmission();
}

// Sets all motors to stopped, useful when ending a program
void DiabloMotorsOff(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_ALL_OFF);
    Wire.endTransmission();
}

/***** General functions *****/

// Reads the board identifier and checks it is a Diablo, false for incorrect, true for correct
bool DiabloCheckId(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_ID);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_I2C_ID_DIABLO) {
        return true;
    } else {
        return false;
    }
}

// Resets the EPO latch state, use to allow movement again after the EPO has been tripped
void DiabloResetEpo(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_RESET_EPO);
    Wire.endTransmission();
}

// Reads the system EPO latch state.
// If false the EPO has not been tripped, and movement is allowed.
// If true the EPO has been tripped, movement is disabled if the EPO is not ignored (see DiabloSetEpoIgnore)
//     Movement can be re-enabled by calling DiabloResetEpo. 
bool DiabloGetEpo(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_EPO);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

// Sets the system to ignore or use the EPO latch, set to false if you have an EPO switch, true if you do not
void DiabloSetEpoIgnore(bool state) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_EPO_IGNORE);
    if (state){
        Wire.write(DIABLO_COMMAND_VALUE_ON);
    } else {
        Wire.write(DIABLO_COMMAND_VALUE_OFF);
    }
    Wire.endTransmission();
}

// Reads the system EPO ignore state, False for using the EPO latch, True for ignoring the EPO latch
bool DiabloGetEpoIgnore(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_EPO_IGNORE);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

// Sets the system to enable or disable the communications failsafe
// The failsafe will turn the motors off unless it is commanded at least once every 1/4 of a second
// Set to True to enable this failsafe, set to False to disable this failsafe
// The failsafe is disabled at power on
void DiabloSetCommsFailsafe(bool state) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_FAILSAFE);
    if (state){
        Wire.write(DIABLO_COMMAND_VALUE_ON);
    } else {
        Wire.write(DIABLO_COMMAND_VALUE_OFF);
    }
    Wire.endTransmission();
}

// Read the current system state of the communications failsafe, true for enabled, false for disabled
// The failsafe will turn the motors off unless it is commanded at least once every 1/4 of a second
bool DiabloGetCommsFailsafe(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_FAILSAFE);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

/***** Encoder based functions *****/

// Sets the system to enable or disable the encoder based move mode
// In encoder move mode (enabled) the DiabloEncoderMoveMotor* commands are available to move fixed distances
// In non-encoder move mode (disabled) the DiabloSetMotor* commands should be used to set drive levels
// The encoder move mode requires that the encoder feedback is attached to an encoder signal, see the website at www.piborg.org/picoborgrev for wiring instructions
// The encoder based move mode is disabled at power on
void DiabloSetEncoderMoveMode(bool state) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_ENC_MODE);
    if (state){
        Wire.write(DIABLO_COMMAND_VALUE_ON);
    } else {
        Wire.write(DIABLO_COMMAND_VALUE_OFF);
    }
    Wire.endTransmission();
}

// Read the current system state of the encoder based move mode, True for enabled (encoder moves), False for disabled (power level moves)
bool DiabloGetEncoderMoveMode(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_ENC_MODE);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

// Moves motor 2 until it has seen a number of encoder counts, up to 32767
// Use negative values to move in reverse
// e.g.
// DiabloEncoderMoveMotor2(100)   -> motor 2 moving forward for 100 counts
// DiabloEncoderMoveMotor2(-50)   -> motor 2 moving reverse for 50 counts
// DiabloEncoderMoveMotor2(5)     -> motor 2 moving forward for 5 counts
void DiabloEncoderMoveMotor2(int counts) {
    Wire.beginTransmission(diabloAddress);
    if (counts < 0) {
        Wire.write(DIABLO_COMMAND_MOVE_A_REV);
        counts = -counts;
    } else {
        Wire.write(DIABLO_COMMAND_MOVE_A_FWD);
    }
    if (counts > 32767) {
        counts = 32767;
    }
    Wire.write((counts >> 8) & 0xFF);
    Wire.write((counts >> 0) & 0xFF);
    Wire.endTransmission();
}

// Moves motor 1 until it has seen a number of encoder counts, up to 32767
// Use negative values to move in reverse
// e.g.
// DiabloEncoderMoveMotor1(100)   -> motor 1 moving forward for 100 counts
// DiabloEncoderMoveMotor1(-50)   -> motor 1 moving reverse for 50 counts
// DiabloEncoderMoveMotor1(5)     -> motor 1 moving forward for 5 counts
void DiabloEncoderMoveMotor1(int counts) {
    Wire.beginTransmission(diabloAddress);
    if (counts < 0) {
        Wire.write(DIABLO_COMMAND_MOVE_B_REV);
        counts = -counts;
    } else {
        Wire.write(DIABLO_COMMAND_MOVE_B_FWD);
    }
    if (counts > 32767) {
        counts = 32767;
    }
    Wire.write((counts >> 8) & 0xFF);
    Wire.write((counts >> 0) & 0xFF);
    Wire.endTransmission();
}

// Moves all motors until they have each seen a number of encoder counts, up to 65535
// Use negative values to move in reverse
// e.g.
// DiabloEncoderMoveMotors(100)   -> all motors moving forward for 100 counts
// DiabloEncoderMoveMotors(-50)   -> all motors moving reverse for 50 counts
// DiabloEncoderMoveMotors(5)     -> all motors moving forward for 5 counts
void DiabloEncoderMoveMotors(int counts) {
    Wire.beginTransmission(diabloAddress);
    if (counts < 0) {
        Wire.write(DIABLO_COMMAND_MOVE_ALL_REV);
        counts = -counts;
    } else {
        Wire.write(DIABLO_COMMAND_MOVE_ALL_FWD);
    }
    if (counts > 32767) {
        counts = 32767;
    }
    Wire.write((byte)((counts >> 8) & 0xFF));
    Wire.write((byte)((counts >> 0) & 0xFF));
    Wire.endTransmission();
}

// Reads the current state of the encoder motion, False for all motors have finished, True for any motor is still moving
bool DiabloIsEncoderMoving(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_ENC_MOVING);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

// Sets the drive limit for encoder based moves
// e.g.
// DiabloSetEncoderSpeed(0.01)  -> motors may move at up to 1% power
// DiabloSetEncoderSpeed(0.1)   -> motors may move at up to 10% power
// DiabloSetEncoderSpeed(0.5)   -> motors may move at up to 50% power
// DiabloSetEncoderSpeed(1)     -> motors may move at up to 100% power
void DiabloSetEncoderSpeed(int power) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_ENC_SPEED);
    if (power > DIABLO_PWM_MAX) {
        Wire.write(DIABLO_PWM_MAX);
    } else {
        Wire.write((byte)power);
    }
    Wire.endTransmission();
}

// Gets the drive limit for encoder based moves
// e.g.
// 0.01  -> motors may move at up to 1% power
// 0.1   -> motors may move at up to 10% power
// 0.5   -> motors may move at up to 50% power
// 1     -> motors may move at up to 100% power
int DiabloGetEncoderSpeed(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_ENC_SPEED);
    Wire.endTransmission();
    ReadInReply();
    return (int)rdBuffer[1];
}

// Sets if the system is powering the motor drive pins
// If True all of the motor pins are either low, high, or PWMed (powered)
// If False all of the motor pins are tri-stated (unpowered)
void DiabloSetEnabled(bool state) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_ENABLED);
    if (state){
        Wire.write(DIABLO_COMMAND_VALUE_ON);
    } else {
        Wire.write(DIABLO_COMMAND_VALUE_OFF);
    }
    Wire.endTransmission();
}

// Reads if the system is currently powering the motor drive pins
// If True all of the motor pins are either low, high, or PWMed (powered)
// If False all of the motor pins are tri-stated (unpowered)
bool DiabloGetEnabled(void) {
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_GET_ENABLED);
    Wire.endTransmission();
    ReadInReply();
    if (rdBuffer[1] == DIABLO_COMMAND_VALUE_OFF) {
        return false;
    } else {
        return true;
    }
}

/***** Advanced functions *****/

// Scans the I2C bus for Diablo boards and returns a count of all the boards found
byte DiabloScanForCount(void) {
    byte found = 0;
    byte oldAddress = diabloAddress;
    for (diabloAddress = DIABLO_MINIMUM_I2C_ADDRESS; diabloAddress <= DIABLO_MAXIMUM_I2C_ADDRESS; ++diabloAddress) {
        if (DiabloCheckId()) {
            ++found;
        }
    }
    diabloAddress = oldAddress;
    return found;
}

// Scans the I2C bus for a Diablo board, index is which address to return (from 0 to count - 1)
// Returns address 0 if no board is found for that index
byte DiabloScanForAddress(byte index) {
    byte found = 0;
    byte oldAddress = diabloAddress;
    for (diabloAddress = DIABLO_MINIMUM_I2C_ADDRESS; diabloAddress <= DIABLO_MAXIMUM_I2C_ADDRESS; ++diabloAddress) {
        if (DiabloCheckId()) {
            if (index == 0) {
                found = diabloAddress;
                break;
            } else {
                --index;
            }
        }
    }
    diabloAddress = oldAddress;
    return found;
}

// Sets the Diablo at the current address to newAddress
// Warning, this new I²C address will still be used after resetting the power on the device
// If successful returns true and updates diabloAddress, otherwise returns false
bool DiabloSetNewAddress(byte newAddress) {
    byte oldAddress = diabloAddress;
    if (newAddress < DIABLO_MINIMUM_I2C_ADDRESS) {
        return false;
    } else if (newAddress > DIABLO_MAXIMUM_I2C_ADDRESS) {
        return false;
    } else if (!DiabloCheckId()) {
        return false;
    }
    Wire.beginTransmission(diabloAddress);
    Wire.write(DIABLO_COMMAND_SET_I2C_ADD);
    Wire.write(newAddress);
    Wire.endTransmission();
    diabloAddress = newAddress;
    if (DiabloCheckId()) {
        return true;
    } else {
        diabloAddress = oldAddress;
        return false;
    }
}
