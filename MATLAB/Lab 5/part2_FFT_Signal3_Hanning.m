%Lachlan McDermott
%Lab 5 Underwater acoustics - Part 2 Signal 3 Hanning Comparison
%2/23/2026

clc;
clear;

%input data
%!!!! CHANGE FILE NAME IN LAB !!!!!
dataFile = 'filefromscopeinlab.csv'; 
data = readmatrix(dataFile); 

%global variables
scopeT = data(:, 1);
scopeV = data(:, 2);
N = length(scopeV);
dt = scopeT(2) - scopeT(1);
fs = 1 / dt;

xAxis = (0:N-1) * (fs / N);

%hann window
hanning = v_scope .* hann(N);

%fft
fft = fft(hanning);
correctionFactor = 2; 

%plot (CHECK LIMITS AND WHATNOT)
subplot(2,1,1);
plot(xAxis / 1000, 2 * abs(fft) / N * correctionFactor);
xlim([0 100]);
grid on;
title('Frequency domain');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');

subplot(2,1,2); 
plot(t_scope * 1000, hanning);
%!!!! FIGURE OUT LIMITS FOR PLOTTING IN LAB BASED ON SCOPE DATA !!!!
xlim([min(t_scope)*1000, max(t_scope)*1000]); 
grid on;
title('Time domain');
xlabel('Time [ms]');
ylabel('Voltage [V]');