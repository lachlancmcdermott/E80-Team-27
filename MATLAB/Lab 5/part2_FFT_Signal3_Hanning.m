%Lachlan McDermott
%Lab 5 Underwater accoustics - Part 2 Signal 3 Plot Hanning
%2/22/2026

clear; 
clc;

%intake data
data = 1.5 * sin(2*pi*10000*10000);

%compute fft
fft = fft(data);
fftToPlot = 2 * (abs(fft) / length(data));