clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
trial1 = dataLog('005'); % Z axis accelerating trial
trial2 = dataLog('005'); % X axis accelerating trial
trial3 = dataLog('005'); % Y axis accelerating trial

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


%GENERATE PLOTS
% X trial 1
figure('Name', 'Zero X', 'NumberTitle', 'off');
clf;
plot(trial1.accelX, 'red'); 
title('Trial 1: Zero X');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Y trial 1
figure('Name', 'Zero Y', 'NumberTitle', 'off');
title('Zero Y')
clf;
plot(trial1.accelY, 'green'); 
title('Trial 1: Zero Y');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Accelerated Z trial 1
figure('Name', 'Accelerated Z', 'NumberTitle', 'off');
clf;
plot(trial1.accelZ, 'blue');
title('Trial 1: Accelerated Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


%Z trial 2
figure('Name', 'Zero Z', 'NumberTitle', 'off');
clf;
plot(trial2.accelZ, 'blue');
title('Trial 2: Zero Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


%Includes description of how to calculate statistics and correct values.
%Includes description of how to calculate T tests and results of tests on data.

%still need

%calibration for zero based off mean values calculated??

%t-tests
%description for statistics
%