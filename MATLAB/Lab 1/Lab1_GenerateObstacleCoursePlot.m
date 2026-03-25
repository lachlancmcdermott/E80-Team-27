%Lab1_GenerateObstacleCoursePlot.m
%Lachlan McDermott
%lmcdermott@hmc.edu
%1/30/2026

clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
test = dataLog('023');

%CALIBRATION
%!!! REPLACE W/ NUMBERS FROM CALIBRATION !!!
xZeroOffset = -8.2000;
yZeroOffset = 29.0800;
zZeroOffset = -12.5120;
scaleFactor = 0.0097;

test.accelX = test.accelX - xZeroOffset;
test.accelY = test.accelY - yZeroOffset;
test.accelZ = test.accelZ - zZeroOffset;

%Generate acceleration plot
figure('Name', 'ROV Acceleration Plot');
hold on;
plot(test.accelX*scaleFactor, 'red', 'LineWidth', 1);
plot(test.accelY*scaleFactor, 'green', 'LineWidth', 1); 
plot(test.accelZ*scaleFactor, 'blue', 'LineWidth', 1); 
xlim([150, 1000]);
hold off;

title('ROV Acceleration through Obstacle Course');
ylabel('Accel [m/s^2]');
xlabel('Samples [count]');
legend('X Acceleration', 'Y Acceleration', 'Z Acceleration');
grid on;
