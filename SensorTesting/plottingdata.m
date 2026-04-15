%% logreader_plot.m
% Reads Teensy log files and plots depth, temperature, pH, and turbidity
clear; clc;

%% --- USER SETTINGS ---
filenum = '112';   % Change this to the file number you want
dt = 0.2;          % Logging loop period in seconds

%% --- FILE NAMES ---
infofile = strcat('INF', filenum, '.TXT');
datafile = strcat('LOG', filenum, '.BIN');

%% --- DATA TYPE SIZE MAP ---
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

%% --- READ INFO FILE ---
fileID = fopen(infofile);
if fileID == -1
    error('Cannot open info file: %s', infofile);
end
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);

[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;  % Teensy log record padding
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end

%% --- READ DATA FILE ---
fid = fopen(datafile,'rb');
if fid == -1
    error('Cannot open data file: %s', datafile);
end

dataStruct = struct();  % store all columns in a struct
for i=1:numel(varTypes)
    fseek(fid, sum(varLengths(1:i-1)), 'bof');  % seek start of column
    colData = fread(fid, Inf, ['*' varTypes{i}], colLength - varLengths(i));
    dataStruct.(varNames{i}) = colData;          % store in struct
end
fclose(fid);

%% --- TIME VECTOR ---
N = length(dataStruct.(varNames{1}));
t = (0:N-1)*dt;

%% --- PLOT DATA ---
figure;

% Depth
subplot(6,1,1);
if isfield(dataStruct,'depth')
    plot(t, dataStruct.depth, 'b', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('Depth (m)');
title('Depth vs Time');

% Temperature / Thermistor
subplot(6,1,2);
if isfield(dataStruct,'temp')
    plot(t, dataStruct.temp, 'm', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature vs Time');

% pH
subplot(6,1,3);
if isfield(dataStruct,'pH_Value')
    plot(t, dataStruct.pH_Value, 'g', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('pH');
title('pH vs Time');

% Turbidity
subplot(6,1,4);
if isfield(dataStruct,'turbidity_90')
    plot(t, dataStruct.turbidity_90, 'c', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('Turbidity 90 degrees (NTU)');
title('Turbidity 90 vs Time');

% Turbidity
subplot(6,1,5);
if isfield(dataStruct,'turbidity_180')
    plot(t, dataStruct.turbidity_180, 'c', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('Turbidity 180 degrees (NTU)');
title('Turbidity 180 vs Time');

% 555 Timer
subplot(6,1,6);
if isfield(dataStruct,'timer')
    plot(t, dataStruct.timer, 'c', 'LineWidth', 1.5);
end
xlabel('Time (s)');
ylabel('555 Timer');
title('555 Timer vs Time');

% Optional: adjust figure size for clarity
set(gcf,'Position',[100 100 600 900]);