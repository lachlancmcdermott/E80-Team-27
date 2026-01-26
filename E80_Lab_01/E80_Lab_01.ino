/********
Default E80 Code
Current Author:
    Wilson Ives (wives@g.hmc.edu) '20 (contributed in 2018)
Previous Contributors:
    Christopher McElroy (cmcelroy@g.hmc.edu) '19 (contributed in 2017)  
    Josephine Wong (jowong@hmc.edu) '18 (contributed in 2016)
    Apoorva Sharma (asharma@hmc.edu) '17 (contributed in 2016)                    
*/

/* Libraries */

// general
#include <Arduino.h>
#include <Wire.h>
#include <Pinouts.h>

// E80-specific
#include <SensorIMU.h>
#include <MotorDriver.h>
#include <Logger.h>
#include <Printer.h>


/* Global Variables */

// period in ms of logger and printer
#define LOOP_PERIOD 100

// Motors
MotorDriver motorDriver;

// IMU
SensorIMU imu;

// Logger
Logger logger;
bool keepLogging = true;

// Printer
Printer printer;

// loop start recorder
int loopStartTime;

void setup() {
  printer.init();

  /* Initialize the Logger */
  logger.include(&imu);
  logger.include(&motorDriver);
  logger.init();

  /* Initialise the sensors */
  imu.init();

  /* Initialize motor pins */
  motorDriver.init();

  /* Keep track of time */
  printer.printMessage("Starting main loop",10);
  loopStartTime = millis();
}


void loop() {

  int currentTime = millis() - loopStartTime;
  
  //////////  Don't change code above here! ////////////////////
  // write code here to make the robot fire its motors in the sequence specified in the lab manual 
  // the currentTime variable contains the number of ms since the robot was turned on 
  // The motorDriver.drive function takes in 3 inputs arguments motorA_power, motorB_power, motorC_power: 
  //       void motorDriver.drive(int motorA_power,int motorB_power,int motorC_power); 
  // the value of motorX_power can range from -255 to 255, and sets the PWM applied to the motor 
  // The following example will turn on motor B for four seconds between seconds 4 and 8 

  // Lachlan McDermott
  // 1/24/2026
  
  // Time variable setup defintion
  const signed long prepAndSealTime   = 10000;
  const signed long diveTime          = 3000;
  const signed long hoopMoveTime      = 6000;
  const signed long surfaceTime       = 3000;

  unsigned long startDiving           = prepAndSealTime;
  unsigned long startHoopMove         = startDiving + diveTime;
  unsigned long startSurfacing        = startHoopMove + hoopMoveTime;
  unsigned long turnOffAUV            = startSurfacing + surfaceTime;

  // IMPORTANT NOTES FOR DEBUGGING!!!
  // Motors A & B horizontal thrusters, motor C is vertical thruster
  // If the robot is moving backwards or spinning check motor spinning direction
  // Before connecting motors check to see which way the propeller spins dry test

  //IMPLEMENT DRY LAND TEST CODE??


  //PREPARATION
  if (currentTime < startDiving) 
  {
    motorDriver.drive(0, 0, 0); 
  }
  else if (currentTime < startHoopMove)
  {
      // If the robot isn't diving invert the power number
    motorDriver.drive(0, 0, 120);
  }
  else if (currentTime > startSurfacing)
  {
    //Might need to add power to motor C to stop the robot from sinking...?
    motorDriver.drive(120, 120, 0);
  }
  else if (currentTime > turnOffAUV)
  {
    motorDriver.drive(0, 0, -120);
  }
  else
  {
    motorDriver.drive(0, 0, 0);
  }

  // DONT CHANGE CODE BELOW THIS LINE 
  // --------------------------------------------------------------------------

  
  if ( currentTime-printer.lastExecutionTime > LOOP_PERIOD ) {
    printer.lastExecutionTime = currentTime;
    printer.printValue(0,imu.printAccels());
    printer.printValue(1,imu.printRollPitchHeading());
    printer.printValue(2,motorDriver.printState());
    printer.printToSerial();  // To stop printing, just comment this line out
  }

  if ( currentTime-imu.lastExecutionTime > LOOP_PERIOD ) {
    imu.lastExecutionTime = currentTime;
    imu.read(); // this is a sequence of blocking I2C read calls
  }

  if ( currentTime-logger.lastExecutionTime > LOOP_PERIOD && logger.keepLogging) {
    logger.lastExecutionTime = currentTime;
    logger.log();
  }

}
