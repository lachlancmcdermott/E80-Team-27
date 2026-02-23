% Lachlan McDermott
% lmcdermott@g.hmc.edu
% 2/3/2026

%load dataz
%MIGHT NOT BE A DOUBLE TBH
data = load('onesevenfivekilohz.txt'); 
%data = load('175HzLachlan.txt');

%dataRMS = rms(data, "all");
%disp(dataRMS)

%global variables
%frequency = 200;
frequency = 175000;
amplitude = 1;
%offsetSignal = 0.4;
offsetSignal = 0.6;

%TEENSY UNIT
pinVoltage = 3.3;
%2^10 (10 bit adc)
teensyUnit = pinVoltage / 1023;
fprintf('One Teensy Unit:\n', teensyUnit);

%plot
figure(1);
clf;
plot(data, 'r');

% + frequency + " Hz Input (" + amplitude + " Vpp)
title(["Teensy Data:"]);
xlabel("Sample Number");
ylabel("Teensy Units (0-1023)");
grid on;



%sample rate
[pks, indexMaxPeak] = findpeaks(data, 'MinPeakHeight', mean(data));

avg = mean(diff(indexMaxPeak));
period = 1/frequency;
sampleRate = avg / period;


fprintf('Average Samples per Cycle: %.2f\n', avg);
fprintf('Calculated Sample Rate: %.2f Hz\n', sampleRate);