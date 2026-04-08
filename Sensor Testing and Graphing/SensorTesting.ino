#include <Arduino.h>
#include <math.h>



// --- PIN DEFINITIONS --- UPDATE WITH ACTUAL PIN NUMBERS
const int TEMP = A2;
const int PRESSURE_PIN = A0;    // Teensy A0
const int PH_PIN = A3;          // Teensy A3
const int TURBIDITY_PIN = A4;   // Teensy A4




// --- SENSOR STATE VARIABLES ---
float temp = 0;
float depth = 0;
float pH_value = 7;
float turbidity = 0;

// VOLTAGE READINGS
float tempVoltage = 0;
float pressureVoltage = 0;
float phVoltage = 0;
float turbidityVoltage = 0;


// UPDATE EVERY SINGLE SLOPE AND INTERCEPT FOR CALIBRATION
void updateTemperature() {
  tempVoltage = analogRead(TEMP) * (3.3 / 1023.0);
  temp =  1.18 * tempVoltage + 1.36;
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
  Serial.print(tempVoltage, 3);
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
  Serial.println("Sensors Online: Temperature, Depth, pH, Turbidity");
}

// --- LOOP ---
void loop() {
  updateTemperature();
  updateDepth();
  updatePH();
  updateTurbidity();
  printSensors();
  delay(200); // print every 0.2 second
}

