#include <Arduino.h>
#include <math.h>
#include <string.h>

#include <Logger.h>
#include <Printer.h>
#include <MotorDriver.h>
#include <DataSource.h>

// --- PIN DEFINITIONS ---
const int TEMP = A10;
const int PRESSURE_PIN = A3;
const int TURBIDITY_90 = A0;
const int TURBIDITY_180 = A1;
const int PH_PIN = A11;
const int TIMER = A2;

// --- SENSOR VALUES ---
float tempVoltage, temp;
float pressureVoltage, depth;
float phVoltage, pH_value;
float turbidity_90Voltage, turbidity_90;
float turbidity_180Voltage, turbidity_180;
float Timer_Voltage;

// --- DEPTH CONTROL CONSTANTS ---
#define DEPTH_MARGIN 0.05
#define Kp 80.0
#define hoverTime 40000
#define motorOffTime 10000

// --- DEPTH CONTROL STATE ---
enum WPState { TRAVELING, HOVERING, MOTOR_OFF };


int totalWayPoints = 4;
int currentWayPoint = 0;
float depth_waypoints[] = {0.5, 1, 2, 0};
float* wayPoints = depth_waypoints;

float uV = 0;
float depth_des = 0;
float depth_error = 0;

bool diveState = true;
bool surfaceState = false;
bool atDepth = false;
bool atSurface = false;
bool complete = false;

WPState wpstate = TRAVELING;
unsigned long stateStartTime = 0;
unsigned long currentTime = 0;

// --- INLINE DATA SOURCE FOR LOGGING ---
class SensorData : public DataSource {
public:
  SensorData()
  : DataSource("temp,depth,pH_Value,turbidity_90,turbidity_180,timer,turbidity_90Voltage,turbidity_180Voltage,tempVoltage,pressureVoltage,phVoltage,depth_des,uV",
               "float,float,float,float,float,float,float,float,float,float,float,float,float") {}

  size_t writeDataBytes(unsigned char * buffer, size_t idx) {
    memcpy(&buffer[idx], &temp, sizeof(float));                idx += sizeof(float);
    memcpy(&buffer[idx], &depth, sizeof(float));               idx += sizeof(float);
    memcpy(&buffer[idx], &pH_value, sizeof(float));            idx += sizeof(float);
    memcpy(&buffer[idx], &turbidity_90, sizeof(float));        idx += sizeof(float);
    memcpy(&buffer[idx], &turbidity_180, sizeof(float));       idx += sizeof(float);
    memcpy(&buffer[idx], &Timer_Voltage, sizeof(float));       idx += sizeof(float);
    memcpy(&buffer[idx], &turbidity_90Voltage, sizeof(float)); idx += sizeof(float);
    memcpy(&buffer[idx], &turbidity_180Voltage, sizeof(float)); idx += sizeof(float);
    memcpy(&buffer[idx], &tempVoltage, sizeof(float));         idx += sizeof(float);
    memcpy(&buffer[idx], &pressureVoltage, sizeof(float));     idx += sizeof(float);
    memcpy(&buffer[idx], &phVoltage, sizeof(float));           idx += sizeof(float);
    memcpy(&buffer[idx], &depth_des, sizeof(float));           idx += sizeof(float);
    memcpy(&buffer[idx], &uV, sizeof(float));           idx += sizeof(float);
    return idx;
  }
};

SensorData sensorData;
MotorDriver motor_driver;
Logger logger;
Printer printer;

// --- SENSOR FUNCTIONS ---
void updateTemperature() {
  tempVoltage = analogRead(TEMP) * (3.3 / 1023.0);
  temp = -4.95 * tempVoltage + 28.4;
}

void updateDepth() {
  pressureVoltage = analogRead(PRESSURE_PIN) * (3.3 / 1023.0);
  depth = -0.848 * pressureVoltage + 2.51;
}

void updatePH() {
  phVoltage = analogRead(PH_PIN) * (3.3 / 1023.0);
  pH_value = 1.23 * phVoltage + 6.37;
}

void updateTurbidity_90() {
  turbidity_90Voltage = analogRead(TURBIDITY_90) * (3.3 / 1023.0);
  turbidity_90 = -1120.4 * turbidity_90Voltage + 5742.3;
}

void updateTurbidity_180() {
  turbidity_180Voltage = analogRead(TURBIDITY_180) * (3.3 / 1023.0);
  turbidity_180 = -1120.4 * turbidity_180Voltage + 5742.3;
}

void update555_Timer() {
  Timer_Voltage = analogRead(TIMER) * (3.3 / 1023.0);
}

String printState() {
  String s = "";
  s += "V_Temp:" + String(tempVoltage, 3) + " Temp:" + String(temp, 2);
  s += " | V_Depth:" + String(pressureVoltage, 3) + " Depth:" + String(depth, 2);
  s += " | V_pH:" + String(phVoltage, 3) + " pH:" + String(pH_value, 2);
  return s;
}

String printState2() {
  String s = "V_Turb_90:" + String(turbidity_90Voltage, 3) + " Turb_90:" + String(turbidity_90, 2);
  s += " V_Turb_180:" + String(turbidity_180Voltage, 3) + " Turb_180:" + String(turbidity_180, 2);
  return s;
}

String printState3() {
  return "555 Timer Voltage:" + String(Timer_Voltage, 3);
}

// --- DEPTH CONTROL FUNCTIONS ---
void dive() {
    if (currentWayPoint >= totalWayPoints) {
    atDepth = true;
    uV = 0;
    return;
    }
  depth_des = wayPoints[currentWayPoint];
  depth_error = depth_des - depth;

  bool atWaypoint = abs(depth_error) < DEPTH_MARGIN;
  switch (wpstate) {
    case TRAVELING:
      uV = Kp * depth_error;
      if (uV > 200) uV = 200;
      else if (uV < -200) uV = -200;
      if (atWaypoint) {
        wpstate = HOVERING;
        stateStartTime = currentTime;
      }
      break;

    case HOVERING:
      uV = Kp * depth_error;
      if (uV > 200) uV = 200;
      else if (uV < -200) uV = -200;
      if (currentTime - stateStartTime >= hoverTime) {
        wpstate = MOTOR_OFF;
        stateStartTime = currentTime;
      }
      break;

    case MOTOR_OFF:
      uV = 0;
      if (currentTime - stateStartTime >= motorOffTime) {
        wpstate = TRAVELING;
        currentWayPoint++;
      }
      break;
  }

  if (currentWayPoint >= totalWayPoints) {
    atDepth = true;
    uV = 0;
  }
}

void surface() {
  depth_des = 0;
  depth_error = depth_des - depth;
  if (abs(depth_error) < DEPTH_MARGIN) {
    atSurface = true;
    complete = true;
    uV = 0;
  } else {
    atSurface = false;
    uV = -30;
  }
}

// ================= SETUP =================
void setup() {
  Serial.begin(9600);
  
  motor_driver.init();        // move this UP
  motor_driver.drive(0,0,0);  // explicitly zero the motors immediately
  delay(30000);
  analogReadResolution(10);

  printer.init();
  motor_driver.init();

  

  logger.include(&sensorData);
  logger.init();

  Serial.println("Hybrid Sensor + DepthControl Started");
}

// ================= LOOP =================
void loop() {
  currentTime = millis();

  // ---- UPDATE SENSORS ----
  updateTemperature();
  updateDepth();
  updatePH();
  updateTurbidity_90();
  updateTurbidity_180();
  update555_Timer();

  //COMMENT OUT THIS SECTION IF YOU DONT WANT PID
  //---- DEPTH CONTROL STATE MACHINE ----
  if (diveState) {
    complete = false;
    if (!atDepth) {
      dive();
    } else {
      diveState = false;
      surfaceState = true;
    }
    motor_driver.drive(0, 0, -uV);
  }


  if (surfaceState) {
    if (!atSurface) {
      surface();
      motor_driver.drive(0, 0, -uV);
    } else {
      motor_driver.drive(0, 0, 0);  // stop motors
    }
  }

  // ---- PRINTING ----
  printer.printValue(0, printState());
  printer.printValue(1, printState2());
  printer.printValue(2, printState3());
  printer.printValue(3, logger.printState());
  printer.printValue(4, "Depth: " + String(depth) + " Depth_Des: " + String(depth_des));
  printer.printValue(5, "uV: " + String(uV));
  printer.printToSerial();

  // ---- LOGGING ----
  if (logger.keepLogging) {
    logger.log();
  }

  delay(50);
}