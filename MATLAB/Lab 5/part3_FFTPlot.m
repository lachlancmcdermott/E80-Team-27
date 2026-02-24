%Lachlan McDermott
%Lab 5 Underwater accoustics - Part 3
%2/22/2026

clear; 
clc;

%intake data
samplingFrequency = 1e9; %Frequency used on the scope
data = [0, 0, 0];

%compute fft
xAxis = (0:length(data)-1) * (samplingFrequency / length(data)); 
fft = fft(data);
fftToPlot = 2 * (abs(fft) / length(data));


%plot fft and stem plot
figure('Name', 'Handclap FFT');

subplot(2,1,1);
grid on;
plot(xAxis / 1000, fftToPlot);
xlim([0 100]); %100 kHz window
ylim([0, 2]);
title('Handclap FFT');
xlabel('Frequency [kHz]');
ylabel('Magnitude [V]');

%stem plot stuff
L = length(data);
f = samplingFrequency*(0:(L/2))/L;
P2 = abs(fft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,1,2); 
stem(f , P1);
