%Lachlan McDermott
%Lab 5 Underwater accoustics - Part 2
%2/22/2026

clear; 
clc;

%global variables
signalAmplitude = 1.5;
signalOffset = 0;

samplingFrequency = 1000000;

signal1Frequency = 11000; %sine wave
signal2Frequency = 12000; %sine wave
signal3Frequency = 11000; %square wave

numebrOfPeriods = 50;

%calculations
totalTime = numebrOfPeriods/signal1Frequency;
t = 0:(1 / samplingFrequency):totalTime;
N = length(t);

sampleCount = length(t);
xAxis = (0:N-1) * (samplingFrequency / sampleCount); %frequency axis 

%generate signals

%!!!!! IN LAB REPLACE THESE WITH DATA !!!!!!
signal1 = signalAmplitude * sin(2*pi*signal1Frequency*t);
signal2 = signalAmplitude * sin(2*pi*signal2Frequency*t);
signal3 = signalAmplitude * square(2*pi*signal3Frequency*t);

%plot signal 1 (rectangular window)
fft1 = fft(signal1);
fft1ToPlot = 2 * (abs(fft1) / N);

figure('Name', 'Signal 1 Data');

subplot(2,1,1);
grid on;
plot(xAxis / 1000, fft1ToPlot);
xlim([0 100]); %100 kHz window
ylim([0, 2]);
title('Signal 1 FFT');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');

%stem plot stuff
L = N; %centered around 0, w/ 100kHz range
f = samplingFrequency*(0:(L/2))/L;
P2 = abs(fft1/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,1,2); 
stem(f , P1);

%Signal 2 rectangular window

fft2 = fft(signal2);
fft2ToPlot = 2 * (abs(fft2) / N);

figure('Name', 'Signal 2 Data');

subplot(2,1,1);
grid on;
plot(xAxis / 1000, fft2ToPlot);
xlim([0 100]); %100 kHz window
ylim([0, 2]);
title('Signal 2 FFT');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');


%stem plot stuff
L = N;
f = samplingFrequency*(0:(L/2))/L;
P2 = abs(fft2/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,1,2); 
stem(f , P1);


%Signal 3 hanning window
fft3 = fft(signal3);
fft3ToPlot = 2 * (abs(fft3) / N);

figure('Name', 'Signal 3 Data');

subplot(2,1,1);
grid on;
plot(xAxis / 1000, fft3ToPlot);
xlim([0 100]); %100 kHz window
ylim([0, 2]);
title('Signal 3 FFT');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');

%stem plot stuff
L = N;
f = samplingFrequency*(0:(L/2))/L;
P2 = abs(fft3/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,1,2); 
stem(f , P1);

