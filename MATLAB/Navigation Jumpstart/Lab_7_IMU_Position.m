clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
%trial1 = dataLog('001'); % accelerating trial



% accelerations
x = trial1.accelY(1:125);
y = trial1.accelX(1:125);

% time
dt = 0.099; % The sampling rate
t = (0:length(x)-1)*dt; % The time array


% velocities
v_x = cumtrapz(t,x); % Integrate the true acceleration to get the true velocity
r_x = cumtrapz(t,v_x); % Integrate the true velocity to get the true position.

% positions
v_y = cumtrapz(t,y); % Integrate the true acceleration to get the true velocity
r_y = cumtrapz(t,v_y); % Integrate the true velocity to get the true position.


position_plots(y);

% ideal line
model_x = linspace(0,0.5,100);
model_y = zeros(1,length(model_x));

figure(4);
hold on
plot(r_x,r_y);
plot(model_x,model_y,'LineWidth',1,'Color','r');

xlabel('x coordinate [m]');
ylabel('y coordinate [m]');
title('ideal versus measured path');
legend('IMU position','ideal position');


