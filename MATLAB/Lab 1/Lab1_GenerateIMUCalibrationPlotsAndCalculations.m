clear; 
clc;

%!!! REPLACE WITH CORRECT TEST FILE NUMBERS DURING LAB !!!
test1 = dataLog('004');
test2 = dataLog('004');
test3 = dataLog('004');

%Acceleration plot calculations
confLev = 0.95;
xbar = mean(accelZ); %Arthimatic mean
S = std(accelZ); %Standard deviation
N = length(accelZ); %Dataset sample count
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


plot(test1.accelX);
hold on;
