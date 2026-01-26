clear; 
clc;

%!!! REPLACE WITH CORRECT TEST FILE NUMBERS DURING LAB !!!
test1 = dataLog('004');
test2 = dataLog('004');
test3 = dataLog('004');

%Acceleration plot calculations
confLev = 0.95;
xbar = mean(test1.accelZ); %Arthimatic mean
S = std(test1.accelZ); %Standard deviation
N = length(test1.accelZ); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

disp('Arthimatic mean');
disp(xbar)
disp('Standard deviation');
disp(S)
disp('Estimated standard error');
disp(ESE)
disp('Confidence interval bounds');
disp(lambda)

%GENERATE PLOTS FROM 1 TRIAL
% X
figure(1);
clf;
plot(test1.accelX, 'red'); 
title('Trial 1: Zero X');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Y
figure(2);
clf;
plot(test1.accelY, 'green'); 
title('Trial 1: Zero Y');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;

% Accelerated Z
figure(3);
clf;
plot(test1.accelZ, 'blue');
title('Test 1: Accelerated Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


%Generate plot for zero Z plot
figure(4);
clf;
plot(test2.accelZ, 'blue');
title('Test 2: Zero Z');
ylabel('Acceleration [millg]');
xlabel('Samples [count]');
axis tight;
grid on;


