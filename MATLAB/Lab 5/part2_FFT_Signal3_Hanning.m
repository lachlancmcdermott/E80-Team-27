%Lachlan McDermott
%Lab 5 Underwater acoustics - Part 2 Signal 3 Hanning Comparison
%2/23/2026

clc;
clear;
close all;

%input data
%!!!! CHANGE FILE NAME IN LAB !!!!!
dataFile = 'scope_1.csv'; 
data = readmatrix(dataFile);
data = data(13:end, :);
data = rmmissing(data); % <--- THIS PURGES ALL NaNs

%global variables
scopeT = data(:, 1);
scopeV = data(:, 2);
N = length(scopeV);

% Robust dt calculation (averages the time steps)
dt = mean(diff(scopeT)); 
fs = 1 / dt;
xAxis = (0:N-1)' * (fs / N);

%fft
fft1 = fft(scopeV);
correctionFactor = 2; 

%plot (CHECK LIMITS AND WHATNOT)
subplot(2,1,1);
plot(xAxis / 1000, 2 * abs(fft1) / N * correctionFactor / 2 / sqrt(2));
xlim([0 100]);
grid on;
title('Frequency domain');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');

subplot(2,1,2); 
plot(scopeT * 1000,scopeV / 2 / sqrt(2));
%!!!! FIGURE OUT LIMITS FOR PLOTTING IN LAB BASED ON SCOPE DATA !!!!
xlim([min(scopeT)*1000, max(scopeT)*1000] ); 
grid on;
title('Time domain');
xlabel('Time [ms]');
ylabel('Voltage [V]');