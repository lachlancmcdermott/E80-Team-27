#include "WaterSensors.h"

// IMPORTANT: use extern to access pins from main
extern const int TEMP;
extern const int PRESSURE_PIN;
extern const int PH_PIN;
extern const int TURBIDITY_PIN;

WaterSensors::WaterSensors()
: DataSource("temp,depth,pH,turbidity", "float,float,float,float")
{}

void WaterSensors::init() {

}

void WaterSensors::update() {
  updateTemperature();
  updateDepth();
  updatePH();
  updateTurbidity();
}

void WaterSensors::updateTemperature() {
  tempVoltage = analogRead(TEMP) * (3.3 / 1023.0);
  temp = 1.18 * tempVoltage + 1.36;
}

void WaterSensors::updateDepth() {
  pressureVoltage = analogRead(PRESSURE_PIN) * (3.3 / 1023.0);
  depth = 1.18 * pressureVoltage + 1.36;
}

void WaterSensors::updatePH() {
  phVoltage = analogRead(PH_PIN) * (3.3 / 1023.0);
  pH_value = -5.7 * phVoltage + 21.34;
}

void WaterSensors::updateTurbidity() {
  turbidityVoltage = analogRead(TURBIDITY_PIN) * (3.3 / 1023.0);
  turbidity = -1120.4 * turbidityVoltage + 5742.3;
}

size_t WaterSensors::writeDataBytes(unsigned char * buffer, size_t idx) {
  memcpy(&buffer[idx], &temp, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &depth, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &pH_value, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &turbidity, sizeof(float)); idx += sizeof(float);
  return idx;
}

String WaterSensors::printState() {
    String s = "";
    s += "V_Temp:" + String(tempVoltage, 3) + " Temp:" + String(temp, 2);
    s += " | V_Depth:" + String(pressureVoltage, 3) + " Depth:" + String(depth, 2);
    s += " | V_pH:" + String(phVoltage, 3) + " pH:" + String(pH_value, 2);
    s += " | V_Turb:" + String(turbidityVoltage, 3) + " Turb:" + String(turbidity, 2);
    return s;
}