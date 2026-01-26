clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
test = dataLog('005');

%convert from teeensy to m/s^2
%subtract off the arithmatic mean after we do conversion

%Generate acceleration plots
figure('Name', 'ROV Acceleration Plot');

subplot(3,1,1);
plot(test.accelX, 'red', 'LineWidth', 1);
title('X Acceleration');
ylabel('Accel [m/s^2]');
axis tight;
grid on;

subplot(3,1,2);
plot(test.accelY, 'green', 'LineWidth', 1);
title('Y Acceleration');
ylabel('Accel [m/s^2]');
axis tight;
grid on;

subplot(3,1,3);
plot(test.accelZ, 'blue', 'LineWidth', 1);
title('Z Acceleration');
ylabel('Accel [m/s^2]');
xlabel('Time [samples]');
axis tight;
grid on;
