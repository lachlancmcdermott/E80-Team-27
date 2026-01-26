clear; 
clc;

%!!! REPLACE WITH CORRECT TRIAL FILE NUMBERS DURING LAB !!!
trial1 = dataLog('004');
trial2 = dataLog('004');
trial3 = dataLog('004');

%Acceleration plot calculations
confLev = 0.95;
xbar = mean(trial1.accelZ); %Arthimatic mean
S = std(trial1.accelZ); %Standard deviation
N = length(trial1.accelZ); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

fprintf('Accelerated Z:\n');
fprintf('\tArithmetic mean:            %.4f\n', xbar);
fprintf('\tStandard deviation:         %.4f\n', S);
fprintf('\tEstimated standard error:   %.4f\n', ESE);
fprintf('\tConfidence interval bounds: %.4f\n', lambda);

xbar = mean(trial1.accelX);
fprintf('\nX mean: %.4f\n', xbar);
xbar = mean(trial1.accelY);
fprintf('Y mean: %.4f\n', xbar);
xbar = mean(trial2.accelZ);
fprintf('Z mean (trial 2): %.4f\n', xbar);

fprintf('\n');


%GENERATE PLOTS FROM 1 TRIAL
% X
figure(1);
clf;
plot(trial1.accelX, 'red'); 
title('Trial 1: Zero X');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Y
figure(2);
clf;
plot(trial1.accelY, 'green'); 
title('Trial 1: Zero Y');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Accelerated Z
figure(3);
clf;
plot(trial1.accelZ, 'blue');
title('Trial 1: Accelerated Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


%Generate plot for zero Z plot
figure(4);
clf;
plot(trial2.accelZ, 'blue');
title('Trial 2: Zero Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


