clear; 
clc;

% Intake data
%distances = [0.0, 0.02, 0.04, 0.06, 0.08, 0.16]; % Note: Check if 0.8 should be 0.08!
%recordedVoltages = [341, 243, 212, 198, 46, 92];

distances = [0.0, 0.02, 0.04, 0.06, 0.16]; % Note: Check if 0.8 should be 0.08!

recordedVoltages = [341, 243, 212, 198, 92];

% 1. Scale voltages FIRST so the model fits the plotted data
scaledVoltages = recordedVoltages / 2 / sqrt(2) + 500;

% Exclude the 0.0 point to prevent log(0)
fit_distances = distances(2:end);
fit_voltages = scaledVoltages(2:end);

% Power-law curve fit
logR = log(fit_distances);
logV = log(fit_voltages);
p = polyfit(logR, logV, 1); 
c = exp(p(2))
exponent = p(1); 

r = linspace(0.01, max(distances), 100);
v = c .* r.^exponent; % Use the calculated exponent for an accurate fit

% Plotting
figure('Name', 'Beacon 1 Magnitude vs. Distance');

yyaxis left;
plot(distances, scaledVoltages, 'o', 'DisplayName', 'Measured voltage magnitude (linear)'); 
hold on;
plot(r, v, 'LineWidth', 1, 'DisplayName', sprintf('Model')); 
ylabel('FFT [V] (linear)');
% Set axis color to match the lines for clarity
ax = gca;
ax.YColor = 'k'; 


yyaxis right;
plot(distances, scaledVoltages, '-', 'LineWidth', 1, 'DisplayName', 'Measured Data (log)');
set(gca, 'YScale', 'log'); % This transforms the right axis to be exponential/logarithmic
ylabel('FFT Magnitude [V] (log)');

% Formatting
grid on;
title('Beacon 1 Voltage vs. Distance');
xlabel('Distance from Beacon (abs) [m]');
legend('Location', 'northeast');