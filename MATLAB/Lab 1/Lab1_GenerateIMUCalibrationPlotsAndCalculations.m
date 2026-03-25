4clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
trial1 = dataLog('001'); % Z axis accelerating trial
trial2 = dataLog('009'); % X axis accelerating trial
trial3 = dataLog('003'); % Y axis accelerating trial

trial2.accelY = trial2.accelY(1:125)
trial2.accelX = trial2.accelX(1:125)
trial2.accelZ = trial2.accelZ(1:125)

trial1.accelY = trial1.accelY(1:125)
trial1.accelX = trial1.accelX(1:125)
trial1.accelZ = trial1.accelZ(1:125)

trial3.accelY = trial3.accelY(1:125)
trial3.accelX = trial3.accelX(1:125)
trial3.accelZ = trial3.accelZ(1:125)


%Calculations and mean values
confLev = 0.95;
xbar = mean(trial1.accelZ); %Arthimatic mean
S = std(trial1.accelZ); %Standard deviation
N = length(trial1.accelZ); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

fprintf('Z Accel mean: %.4f ± %.4f (95%% confidence)\n', xbar, lambda);
fprintf('Std. deviation: %.4f\n', S);
fprintf('Std. error: %.4f\n', ESE);
fprintf(' \n');

xbar = mean(trial1.accelX); %Arthimatic mean
S = std(trial1.accelX); %Standard deviation
N = length(trial1.accelX); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

fprintf('X Zero mean: %.4f ± %.4f (95%% confidence)\n', xbar, lambda)
fprintf('Std. deviation: %.4f\n', S);
fprintf('Std. error: %.4f\n', ESE);
fprintf(' \n');

xbar = mean(trial1.accelY); %Arthimatic mean
S = std(trial1.accelY); %Standard deviation
N = length(trial1.accelY); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

fprintf('Y Zero mean: %.4f ± %.4f (95%% confidence)\n', xbar, lambda)
fprintf('Std. deviation: %.4f\n', S);
fprintf('Std. error: %.4f\n', ESE);
fprintf(' \n');

xbar = mean(trial2.accelZ); %Arthimatic mean
S = std(trial2.accelZ); %Standard deviation
N = length(trial2.accelZ); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

fprintf('Z Zero mean: %.4f ± %.4f (95%% confidence)\n', xbar, lambda)
fprintf('Std. deviation: %.4f\n', S);
fprintf('Std. error: %.4f\n', ESE);
fprintf(' \n');

%T-TEST AND DATA
%x vs. y
[h1,p1,ci,stats] = ttest(trial1.accelX, trial1.accelY);
fprintf('x vs. y: P-Value is %.4e\n', p1);
fprintf('x vs. y: h is %.e\n', h1);

%x vs. z    
[h2, p2] = ttest(trial2.accelX, trial2.accelZ);
fprintf('x vs. z: P-Value is %.4e\n', p2);
fprintf('x vs. z: h is %.e\n', h2);

%y vs. z
[h3, p3] = ttest(trial3.accelY, trial3.accelZ);
fprintf('y vs. z: P-Value is %.4e\n', p3);
fprintf('y vs. z: h is %.e\n', h3);


%CONVERSION TO M/S^2
% We know that (Accel Value) - (Zero Value) = 1g = 9.81 m/s^2.
% We calculate how many raw "units" correspond to 1 m/s^2.

zData = mean(trial1.accelZ);
scaleFactor = 9.8 / zData;
fprintf('Scale factor %.4e', scaleFactor);

%GENERATE PLOTS
figure('Name', 'Calibration Plots', 'NumberTitle', 'off');

%X Zero
subplot(2, 2, 1);
plot(trial1.accelX, 'red'); 
title('Trial 1: Zero X');
ylabel('Teensy units [count]');
xlabel('Samples [count]');
xlim([0 125]);
grid on;

%Y Zero
subplot(2, 2, 2);
plot(trial1.accelY, 'green'); 
title('Trial 1: Zero Y');
ylabel('Teensy units [count]');
xlabel('Samples [count]');
xlim([0 125]);
grid on;

%Z accelerated
subplot(2, 2, 3);
plot(trial1.accelZ, 'blue');
title('Trial 1: Accelerated Z');
ylabel('Teensy units [count]');
xlabel('Samples [count]');
xlim([0 125]);
grid on;

%Z zero
subplot(2, 2, 4);
plot(trial2.accelZ, 'blue');
title('Trial 2: Zero Z');
ylabel('Teensy units [count]');
xlabel('Samples [count]');
xlim([0 125]);
grid on;