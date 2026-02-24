%Lachlan McDermott
%Lab 5 Underwater accoustics - Part 4
%2/22/2026

clear; 
clc;

%intake data
%!!!! replace in lab with data from measurements !!!!

distances = [0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40];
%spacing rel to the wall and the beacon
recordedVoltages = [1.80, 1.5, 0.45, 30, 0.98, 0.65, 0.1, 0.2];
%fft max magnitude 


%theoretical curve
logR= log(distances);
logV = log(recordedVoltages);

%p = polyfit(x,y,n) returns the coefficients for a polynomial p(x) of degree n that is a best fit (in a least-squares sense) for the data in y. 
% The coefficients in p are in descending powers, and the length of p is
% n+1 yayahdah...

p = polyfit(logR, logV, 1); 
c = exp(p(2));

r = linspace(min(distances), max(distances), 100);
v = c./r;

%plot
figure('Name', 'Beacon Magnitude vs. Distance');
grid on;

plot(distances, recordedVoltages); 
hold on;

plot(r, v); 

title('Beacon Received Voltage Magnitude vs. Distance');
xlabel('Distance from Beacon (abs) [m]');
ylabel('Received FFT Magnitude [V]');
equationLegend = sprintf('Analytical Model (V = %.3f / r)', c);
legend('Measured Data (w/ Multipath)', equationLegend);