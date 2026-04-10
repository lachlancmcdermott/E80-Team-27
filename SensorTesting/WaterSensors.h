#ifndef WATER_SENSORS_H
#define WATER_SENSORS_H

#include <Arduino.h>
#include "DataSource.h"

extern const int TEMP;
extern const int PRESSURE_PIN;
extern const int PH_PIN;
extern const int TURBIDITY_PIN;


class WaterSensors : public DataSource {
public:
  WaterSensors();

  void init();
  void update();

  virtual size_t writeDataBytes(unsigned char * buffer, size_t idx);

  String printState();
  String printState2();

  // sensor values
  float temp;
  float depth;
  float pH_value;
  float turbidity;

  // voltages
  float tempVoltage;
  float pressureVoltage;
  float phVoltage;
  float turbidityVoltage;

private:
  void updateTemperature();
  void updateDepth();
  void updatePH();
  void updateTurbidity();
};

#endif