#include <Arduino.h>
#include <math.h>

#include "WaterSensors.h"
#include <Logger.h>
#include <Printer.h>
#include <string.h>

// --- PIN DEFINITIONS ---
const int TEMP = A0;
const int PRESSURE_PIN = A1;
const int TURBIDITY_90 = A2;
const int TURBIDITY_180 = A3;
const int PH_PIN = A10;

// --- GLOBAL OBJECTS ---
WaterSensors sensors;
Logger logger;
Printer printer;

void setup() {
  Serial.begin(9600);
  analogReadResolution(10);

  printer.init();

  sensors.init();

  logger.include(&sensors);
  logger.init();

  Serial.println("Sensors + SD Logging Started");
}

void loop() {
  sensors.update();

  // Print to serial using Printer (E80 style)
  printer.printValue(0, sensors.printState());
  printer.printValue(1, sensors.printState2());
  printer.printValue(2, logger.printState());
  printer.printToSerial();

  // Log to SD card
  if (logger.keepLogging) {
    logger.log();
  }

  delay(200);
}