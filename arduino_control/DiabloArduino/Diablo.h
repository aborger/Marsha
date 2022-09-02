/****************************/
/***** Diablo Constants *****/
/****************************/

// Commands
// GET commands sent should be followed by a read for the result
// All other commands are send only (no reply)
#define DIABLO_COMMAND_SET_A_FWD       (3)     // Set motor 2 PWM rate in a forwards direction
#define DIABLO_COMMAND_SET_A_REV       (4)     // Set motor 2 PWM rate in a reverse direction
#define DIABLO_COMMAND_GET_A           (5)     // Get motor 2 direction and PWM rate
#define DIABLO_COMMAND_SET_B_FWD       (6)     // Set motor 1 PWM rate in a forwards direction
#define DIABLO_COMMAND_SET_B_REV       (7)     // Set motor 1 PWM rate in a reverse direction
#define DIABLO_COMMAND_GET_B           (8)     // Get motor 1 direction and PWM rate
#define DIABLO_COMMAND_ALL_OFF         (9)     // Switch everything off
#define DIABLO_COMMAND_RESET_EPO       (10)    // Resets the EPO flag, use after EPO has been tripped and switch is now clear
#define DIABLO_COMMAND_GET_EPO         (11)    // Get the EPO latched flag
#define DIABLO_COMMAND_SET_EPO_IGNORE  (12)    // Set the EPO ignored flag, allows the system to run without an EPO
#define DIABLO_COMMAND_GET_EPO_IGNORE  (13)    // Get the EPO ignored flag
#define DIABLO_COMMAND_SET_ALL_FWD     (15)    // Set all motors PWM rate in a forwards direction
#define DIABLO_COMMAND_SET_ALL_REV     (16)    // Set all motors PWM rate in a reverse direction
#define DIABLO_COMMAND_SET_FAILSAFE    (17)    // Set the failsafe flag, turns the motors off if communication is interrupted
#define DIABLO_COMMAND_GET_FAILSAFE    (18)    // Get the failsafe flag
#define DIABLO_COMMAND_SET_ENC_MODE    (19)    // Set the board into encoder or speed mode
#define DIABLO_COMMAND_GET_ENC_MODE    (20)    // Get the boards current mode, encoder or speed
#define DIABLO_COMMAND_MOVE_A_FWD      (21)    // Move motor 2 forward by n encoder ticks
#define DIABLO_COMMAND_MOVE_A_REV      (22)    // Move motor 2 reverse by n encoder ticks
#define DIABLO_COMMAND_MOVE_B_FWD      (23)    // Move motor 1 forward by n encoder ticks
#define DIABLO_COMMAND_MOVE_B_REV      (24)    // Move motor 1 reverse by n encoder ticks
#define DIABLO_COMMAND_MOVE_ALL_FWD    (25)    // Move all motors forward by n encoder ticks
#define DIABLO_COMMAND_MOVE_ALL_REV    (26)    // Move all motors reverse by n encoder ticks
#define DIABLO_COMMAND_GET_ENC_MOVING  (27)    // Get the status of encoders moving
#define DIABLO_COMMAND_SET_ENC_SPEED   (28)    // Set the maximum PWM rate in encoder mode
#define DIABLO_COMMAND_GET_ENC_SPEED   (29)    // Get the maximum PWM rate in encoder mode
#define DIABLO_COMMAND_SET_ENABLED     (30)    // Set if the motor drives are enabled
#define DIABLO_COMMAND_GET_ENABLED     (31)    // Get the motor drive enabled state
#define DIABLO_COMMAND_GET_ID          (0x99)  // Get the board identifier
#define DIABLO_COMMAND_SET_I2C_ADD     (0xAA)  // Set a new I2C address

// Values
// These are the corresponding numbers for states used by the above commands
#define DIABLO_COMMAND_VALUE_FWD       (1)     // I2C value representing forward
#define DIABLO_COMMAND_VALUE_REV       (2)     // I2C value representing reverse
#define DIABLO_COMMAND_VALUE_ON        (1)     // I2C value representing on
#define DIABLO_COMMAND_VALUE_OFF       (0)     // I2C value representing off
#define DIABLO_I2C_ID_DIABLO           (0x37)  // I2C values returned when calling the GET_ID command
#define DIABLO_DEFAULT_I2C_ADDRESS     (0x44)  // I2C address set by default (before using SET_I2C_ADD)
#define DIABLO_ERROR_READING           (888)   // Returned from GetMotor commands when value failed to read

// Limits
// These define the maximums that the Diablo will accept
#define DIABLO_I2C_MAX_LEN             (4)     // Maximum number of bytes in an I2C message
#define DIABLO_PWM_MAX                 (255)   // Maximum I2C value for speed settings (represents 100% drive)
#define DIABLO_MINIMUM_I2C_ADDRESS     (0x03)  // Minimum allowed value for the I2C address
#define DIABLO_MAXIMUM_I2C_ADDRESS     (0x77)  // Maximum allowed value for the I2C address

/*****************************/
/***** Diablo Properties *****/
/*****************************/

// Types
typedef unsigned char byte;                 // Define the term 'byte' if it has not been already

// Values
extern byte diabloAddress;                     // The I2C address we are currently talking to

/****************************/
/***** Diablo Functions *****/
/****************************/
// All motor drive levels are from +DIABLO_PWM_MAX to -DIABLO_PWM_MAX
// Positive values indicate forwards motion
// Negative values indicate reverse motion
// 0 indicates stationary
// Values outside DIABLO_PWM_MAX will be capped to DIABLO_PWM_MAX (100%)

/***** Motor functions *****/

// Sets the drive level for motor 2
void DiabloSetMotor2(int power);

// Gets the drive level for motor 2
int DiabloGetMotor2(void);

// Sets the drive level for motor 1
void DiabloSetMotor1(int power);

// Gets the drive level for motor 1
int DiabloGetMotor1(void);

// Sets the drive level for all motors
void DiabloSetMotors(int power);

// Sets all motors to stopped, useful when ending a program
void DiabloMotorsOff(void);

/***** General functions *****/

// Reads the board identifier and checks it is a Diablo, false for incorrect, true for correct
bool DiabloCheckId(void);

// Resets the EPO latch state, use to allow movement again after the EPO has been tripped
void DiabloResetEpo(void);

// Reads the system EPO latch state.
// If false the EPO has not been tripped, and movement is allowed.
// If true the EPO has been tripped, movement is disabled if the EPO is not ignored (see DiabloSetEpoIgnore)
//     Movement can be re-enabled by calling DiabloResetEpo. 
bool DiabloGetEpo(void);

// Sets the system to ignore or use the EPO latch, set to false if you have an EPO switch, true if you do not
void DiabloSetEpoIgnore(bool state);

// Reads the system EPO ignore state, False for using the EPO latch, True for ignoring the EPO latch
bool DiabloGetEpoIgnore(void);

// Sets the system to enable or disable the communications failsafe
// The failsafe will turn the motors off unless it is commanded at least once every 1/4 of a second
// Set to True to enable this failsafe, set to False to disable this failsafe
// The failsafe is disabled at power on
void DiabloSetCommsFailsafe(bool state);

// Read the current system state of the communications failsafe, true for enabled, false for disabled
// The failsafe will turn the motors off unless it is commanded at least once every 1/4 of a second
bool DiabloGetCommsFailsafe(void);

/***** Encoder based functions *****/

// Sets the system to enable or disable the encoder based move mode
// In encoder move mode (enabled) the EncoderMoveMotor* commands are available to move fixed distances
// In non-encoder move mode (disabled) the SetMotor* commands should be used to set drive levels
// The encoder move mode requires that the encoder feedback is attached to an encoder signal, see the website at www.piborg.org/picoborgrev for wiring instructions
// The encoder based move mode is disabled at power on
void SetEncoderMoveMode(bool state);

// Read the current system state of the encoder based move mode, True for enabled (encoder moves), False for disabled (power level moves)
bool GetEncoderMoveMode(void);

// Moves motor 2 until it has seen a number of encoder counts, up to 32767
// Use negative values to move in reverse
// e.g.
// EncoderMoveMotor2(100)   -> motor 2 moving forward for 100 counts
// EncoderMoveMotor2(-50)   -> motor 2 moving reverse for 50 counts
// EncoderMoveMotor2(5)     -> motor 2 moving forward for 5 counts
void EncoderMoveMotor2(int counts);

// Moves motor 1 until it has seen a number of encoder counts, up to 32767
// Use negative values to move in reverse
// e.g.
// EncoderMoveMotor1(100)   -> motor 1 moving forward for 100 counts
// EncoderMoveMotor1(-50)   -> motor 1 moving reverse for 50 counts
// EncoderMoveMotor1(5)     -> motor 1 moving forward for 5 counts
void EncoderMoveMotor1(int counts);

// Moves all motors until they have each seen a number of encoder counts, up to 65535
// Use negative values to move in reverse
// e.g.
// EncoderMoveMotors(100)   -> all motors moving forward for 100 counts
// EncoderMoveMotors(-50)   -> all motors moving reverse for 50 counts
// EncoderMoveMotors(5)     -> all motors moving forward for 5 counts
void EncoderMoveMotors(int counts);

// Reads the current state of the encoder motion, False for all motors have finished, True for any motor is still moving
bool IsEncoderMoving(void);

// Sets the drive limit for encoder based moves, from 0 to 1.
// e.g.
// SetEncoderSpeed(0.01)  -> motors may move at up to 1% power
// SetEncoderSpeed(0.1)   -> motors may move at up to 10% power
// SetEncoderSpeed(0.5)   -> motors may move at up to 50% power
// SetEncoderSpeed(1)     -> motors may move at up to 100% power
void SetEncoderSpeed(int power);

// Gets the drive limit for encoder based moves, from 0 to 1.
// e.g.
// 0.01  -> motors may move at up to 1% power
// 0.1   -> motors may move at up to 10% power
// 0.5   -> motors may move at up to 50% power
// 1     -> motors may move at up to 100% power
int GetEncoderSpeed(void);

// Sets if the system is powering the motor drive pins
// If True all of the motor pins are either low, high, or PWMed (powered)
// If False all of the motor pins are tri-stated (unpowered)
void DiabloSetEnabled(bool state);

// Reads if the system is currently powering the motor drive pins
// If True all of the motor pins are either low, high, or PWMed (powered)
// If False all of the motor pins are tri-stated (unpowered)
bool DiabloGetEnabled(void);

/***** Advanced functions *****/

// Scans the I2C bus for Diablo boards and returns a count of all the boards found
byte DiabloScanForCount(void);

// Scans the I2C bus for a Diablo board, index is which address to return (from 0 to count - 1)
// Returns address 0 if no board is found for that index
byte DiabloScanForAddress(byte index);

// Sets the Diablo at the current address to newAddress
// Warning, this new I²C address will still be used after resetting the power on the device
// If successful returns true and updates diabloAddress, otherwise returns false
bool DiabloSetNewAddress(byte newAddress);

