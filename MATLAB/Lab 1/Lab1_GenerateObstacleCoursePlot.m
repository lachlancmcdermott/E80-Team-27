clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
test = dataLog('004');

%CALIBRATION
%!!! REPLACE W/ NUMBERS FROM CALIBRATION !!!
xZeroOffset = -34.0029;
yZeroOffset = 100;
zZeroOffset = 100;
scaleFactor = 1.2035e-02;

test.accelX = test.accelX - xZeroOffset;
test.accelY = test.accelY - yZeroOffset;
test.accelZ = test.accelZ - zZeroOffset;

%Generate acceleration plots
figure('Name', 'ROV Acceleration Plot');
hold on;
plot(test.accelX*scaleFactor, 'red', 'LineWidth', 1);
plot(test.accelY*scaleFactor, 'green', 'LineWidth', 1); 
plot(test.accelZ*scaleFactor, 'blue', 'LineWidth', 1); 
hold off;

title('ROV Acceleration through Obstacle Course');
ylabel('Accel [m/s^2]');
xlabel('Time [samples]');
legend('X Acceleration', 'Y Acceleration', 'Z Acceleration');
grid on;
