%Plots of desired and experimental
clear;
clc;

% Load your data (change file number if needed)
trial1 = dataLog('001');
fieldnames(trial1); % Check names

% Extract relevant data
depth = trial1.depth;              % actual depth
          % vertical motor effort
temp = trial1.temp; % temperature in °C (or uV if raw)
ph = trial1.pH_value;                % pH readings
turbidity = trial1.turbidity;  % turbidity readings (NTU or similar)

% Time vector
dt = 0.2; % LOOP_PERIOD
N = length(depth);
t = (0:N-1)*dt;

%% Plot Depth
figure;
subplot(4,1,1);
plot(t, depth, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Depth (m)');
title('Depth vs Time');


%% Plot Temperature
subplot(4,1,2);
plot(t, thermistor, 'm', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Thermistor vs Time');

%% Plot pH
subplot(4,1,3);
plot(t, ph, 'g', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('pH');
title('pH vs Time');

%% Plot Turbidity
subplot(4,1,4);
plot(t, turbidity, 'c', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Turbidity (NTU)');
title('Turbidity vs Time');

% Optional: make the plots tighter for readability
tightfig;
