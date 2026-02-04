%call the dataLog.m function in order to process files taken from Teensy,
%expect output to be a 10000x2 matrix with sample number and voltage

output = dataLog('004');
frequency = 200;
%frequency = 175000
amplitude = 1
offsetSignal = 0.6

%generate plot of sample versus measured voltage

figure(1);
clf;
plot(output,"red");
title("Data from input signal " + frequency + " Hz, " + amplitude + " Vpp, " + offsetSignal + " V");
xlabel("Sample Count");
ylabel("Voltage Measurement");
grid on;

%expect output of SD card to be 10,000 samples, need to find indices of
%peaks

[indicesOfMaximums] = findpeaks(output(:,2));

%define known frequency of signal, then convert to period and then divide
%by number of samples to find sampling rate

period = 1/frequency;
samplingRate = (indicesOfMaximums(2)-indicesOfMaximums(1))/period



