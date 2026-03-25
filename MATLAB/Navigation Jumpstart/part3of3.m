clear;
clc;

% Load your data (change file number if needed)
trial1 = dataLog('001');
fieldnames(trial1); %Check names

depth = trial1.z;              % actual depth
uV = trial1.uV;                % Vertical Motor Effort
depth_des = trial1.depth_des;  % desired depth

% Time vector
dt = 0.099; % LOOP_PERIOD
N = length(depth);

t = (0:N-1)*dt;

% Plot everything
figure;
subplot(2,1,1);
plot(t, depth, 'b', 'LineWidth', 1.5);
hold on;
plot(t, depth_des, 'r', 'LineWidth', 1.5);
hold off;
xlabel('Time (s)');
ylabel('Distance (m)');
title('Depth and Depth Desired vs Time');
legend('Depth', 'Depth Desired');
subplot(2,1,2);
plot(t, uV, 'c', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Vertical Motor Effort uV (units)');
title('Vertical Motor Effort vs Time');
