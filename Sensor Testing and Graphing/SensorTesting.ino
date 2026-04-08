#include <Arduino.h>
#include <math.h>



// --- PIN DEFINITIONS --- UPDATE WITH ACTUAL PIN NUMBERS
const int THERM = A2;
const int PRESSURE_PIN = A0;    // Teensy A0
const int PH_PIN = A3;          // Teensy A3
const int TURBIDITY_PIN = A4;   // Teensy A4


// --- THERMISTOR CONSTANTS --- UPDATE WITH ACTUAL VALUES
const float BETA = 3950.0;
const float R_NOMINAL = 100000.0; // 100k ohms
const float T_NOMINAL = 298.15;   // 25C in Kelvin
const float V_SOURCE = 5.0;       // Voltage divider
const float R_FIXED = 100000.0;   // Bottom resistor
const float GAIN = 2.7;           
const float OFFSET_CONST = 7.63125; 

// --- SENSOR STATE VARIABLES ---
float temp = 0;
float depth = 0;
float pH_value = 7;
float turbidity = 0;

// VOLTAGE READINGS
float thermVoltage = 0;
float pressureVoltage = 0;
float phVoltage = 0;
float turbidityVoltage = 0;

// --- HELPER FUNCTIONS ---
float calculateTemperature(float vOut) {
  float vIn = (OFFSET_CONST - vOut) / GAIN;
  if (vIn <= 0.01 || vIn >= V_SOURCE) return -999.0; 

  float rTherm = R_FIXED * ((V_SOURCE / vIn) - 1.0);
  float steinhart = log(rTherm / R_NOMINAL) / BETA + 1.0 / T_NOMINAL;
  steinhart = 1.0 / steinhart;
  return steinhart - 273.15; // Convert Kelvin to Celsius
}


// UPDATE EVERY SINGLE SLOPE AND INTERCEPT FOR CALIBRATION
void updateThermistors() {
  thermVoltage = analogRead(THERM) * (3.3 / 1023.0);
  temp = calculateTemperature(thermVoltage);
}

void updateDepth() {
  pressureVoltage = analogRead(PRESSURE_PIN) * (3.3 / 1023.0);
  depth = 1.18 * pressureVoltage + 1.36;
}

void updatePH() {
  phVoltage = analogRead(PH_PIN) * (3.3 / 1023.0);
  pH_value = -5.7 * phVoltage + 21.34;
}

void updateTurbidity() {
  turbidityVoltage = analogRead(TURBIDITY_PIN) * (3.3 / 1023.0);
  turbidity = -1120.4 * turbidityVoltage + 5742.3;
}

void printSensors() {
  Serial.print("Temp: ");
  Serial.print(temp, 2);
  Serial.print(" °C (");
  Serial.print(thermVoltage, 3);
  Serial.print(" V)\t");
  Serial.println();

  Serial.print("Depth: ");
  Serial.print(depth, 2);
  Serial.print(" m (");
  Serial.print(pressureVoltage, 3);
  Serial.print(" V)\t");
  Serial.println();

  Serial.print("pH: ");
  Serial.print(pH_value, 2);
  Serial.print(" (");
  Serial.print(phVoltage, 3);
  Serial.print(" V)\t");
  Serial.println();
  
  Serial.print("Turbidity: ");
  Serial.print(turbidity, 2);
  Serial.print(" NTU (");
  Serial.print(turbidityVoltage, 3);
  Serial.print(" V)");

  Serial.println();
}

// --- SETUP ---
void setup() {
  Serial.begin(9600);
  
  // Can be 10 or 12bit
  analogReadResolution(10); // Teensy default
  Serial.println("Sensors Online: Thermistors, Depth, pH, Turbidity");
}

// --- LOOP ---
void loop() {
  updateThermistors();
  updateDepth();
  updatePH();
  updateTurbidity();
  printSensors();
  delay(200); // print every 0.2 second
}

