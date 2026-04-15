#include "WaterSensors.h"
#include <string.h>

// IMPORTANT: use extern to access pins from main
extern const int TEMP;
extern const int PRESSURE_PIN;
extern const int TURBIDITY_90;
extern const int TURBIDITY_180;
extern const int PH_PIN;
extern const int TIMER;

WaterSensors::WaterSensors()
: DataSource("temp,depth,pH_Value,turbidity_90,turbidity_180,timer", "float,float,float,float,float,float")
{}

void WaterSensors::init() {

}

void WaterSensors::update() {
  updateTemperature();
  updateDepth();
  updatePH();
  updateTurbidity_90();
  updateTurbidity_180();
  update555_Timer();
}

void WaterSensors::updateTemperature() {
  tempVoltage = analogRead(TEMP) * (3.3 / 1023.0);
  temp = -4.95 * tempVoltage + 28.4;
}

void WaterSensors::updateDepth() {
  pressureVoltage = analogRead(PRESSURE_PIN) * (3.3 / 1023.0);
  depth = -0.848 * pressureVoltage + 2.6;
}

void WaterSensors::updatePH() {
  phVoltage = analogRead(PH_PIN) * (3.3 / 1023.0);
  pH_value = 1.23 * phVoltage + 6.37;
}

void WaterSensors::updateTurbidity_90() {
  turbidity_90Voltage = analogRead(TURBIDITY_90) * (3.3 / 1023.0);
  turbidity_90 = -1120.4 * turbidity_90Voltage + 5742.3;
}

void WaterSensors::updateTurbidity_180() {
  turbidity_180Voltage = analogRead(TURBIDITY_180)*(3.3 / 1023.0);
  turbidity_180 = -1120.4 * turbidity_180Voltage + 5742.3;
}

void WaterSensors::update555_Timer() {
  Timer_Voltage = analogRead(TIMER)*(3.3 / 1023.0);
}

size_t WaterSensors::writeDataBytes(unsigned char * buffer, size_t idx) {
  memcpy(&buffer[idx], &temp, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &depth, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &pH_value, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &turbidity_90, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &turbidity_180, sizeof(float)); idx += sizeof(float);
  memcpy(&buffer[idx], &Timer_Voltage, sizeof(float)); idx += sizeof(float);
  return idx;
}

String WaterSensors::printState() {
    String s = "";
    s += "V_Temp:" + String(tempVoltage, 3) + " Temp:" + String(temp, 2);
    s += " | V_Depth:" + String(pressureVoltage, 3) + " Depth:" + String(depth, 2);
    s += " | V_pH:" + String(phVoltage, 3) + " pH:" + String(pH_value, 2);

    return s;
}
String WaterSensors::printState2() {
    String s = "V_Turb_90:" + String(turbidity_90Voltage, 3) + " Turb_90:" + String(turbidity_90, 2);
    s += " V_Turb_180:" + String(turbidity_180Voltage, 3) + " Turb_180:" + String(turbidity_180, 2);
    return s;
}

String WaterSensors::printState3() {
    String s = "555 Timer Voltage:" + String(Timer_Voltage, 3);
    return s;
}