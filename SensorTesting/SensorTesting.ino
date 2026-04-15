#include <Arduino.h>
#include <math.h>

#include "WaterSensors.h"
#include <Logger.h>
#include <Printer.h>
#include <string.h>

// --- E80 CONTROL INCLUDES ---
#include <MotorDriver.h>
#include <DepthControl.h>
#include <ZStateEstimator.h>

// --- PIN DEFINITIONS ---
const int TEMP = A10;
const int PRESSURE_PIN = A3;
const int TURBIDITY_90 = A0;
const int TURBIDITY_180 = A1;
const int PH_PIN = A11;
const int TIMER = A2;

// --- GLOBAL OBJECTS ---
WaterSensors sensors;
Logger logger;
Printer printer;

MotorDriver motor_driver;
DepthControl depth_control;
ZStateEstimator z_state_estimator;

// Timing
unsigned long currentTime = 0;

// ================= SETUP =================
void setup() {
  Serial.begin(9600);
  analogReadResolution(10);

  printer.init();
  sensors.init();

  motor_driver.init();
  z_state_estimator.init();

  // --- Depth waypoints (same as original E80) ---
  int diveDelay = 60000;
  const int num_depth_waypoints = 4;
  double depth_waypoints[] = {0.5, 1, 1.5, 2};

  depth_control.init(num_depth_waypoints, depth_waypoints, diveDelay);

  // Logging
  logger.include(&sensors);
  logger.include(&depth_control);
  logger.include(&motor_driver);
  logger.init();

  Serial.println("Hybrid Sensor + DepthControl Started");
}

// ================= LOOP =================
void loop() {
  currentTime = millis();

  // ---- UPDATE SENSORS ----
  sensors.update();

  // ---- INJECT DEPTH INTO ESTIMATOR ----
  // IMPORTANT: may need sign flip (see below)
  z_state_estimator.state.z = sensors.depth;

  // ---- DEPTH CONTROL STATE MACHINE ----
  if (depth_control.diveState) {
    depth_control.complete = false;

    if (!depth_control.atDepth) {
      depth_control.dive(&z_state_estimator.state, currentTime);
    } else {
      depth_control.diveState = false;
      depth_control.surfaceState = true;
    }

    motor_driver.drive(0, 0, depth_control.uV);
  }

  if (depth_control.surfaceState) {
    if (!depth_control.atSurface) {
      depth_control.surface(&z_state_estimator.state);
    } else if (depth_control.complete) {
      delete[] depth_control.wayPoints;
    }

    motor_driver.drive(0, 0, depth_control.uV);
  }

  // ---- PRINTING ----
  printer.printValue(0, sensors.printState());
  printer.printValue(1, sensors.printState2());
  printer.printValue(2, sensors.printState3());
  printer.printValue(3, logger.printState());
  printer.printValue(4, "Depth: " + String(sensors.depth));
  printer.printValue(5, "uV: " + String(depth_control.uV));
  printer.printToSerial();

  // ---- LOGGING ----
  if (logger.keepLogging) {
    logger.log();
  }

  delay(50);
}