clear; 
clc;

%!!! REPLACE WITH CORRECT TEST NUMBERS !!!
test = dataLog('004');

%% Process your data here
%Generate acceleration plot for underwater course
figure('Name', 'ROV Acceleration Plot');
plot(test.accelX, 'red', 'LineWidth', 1); 
hold on;
plot(test.accelY, 'green', 'LineWidth', 1);
plot(test.accelZ, 'blue', 'LineWidth', 1);

%FOR DATA TRIMMING
axis([0 63 -400 1400])

xlabel('Time [samples]')
ylabel('Acceleration [m/s^2]')
title('Measured ROV Acceleration in Obstacle Course')
legend('x Acceleration', 'y Acceleration', 'z Acceleration');
    
grid on
hold off
