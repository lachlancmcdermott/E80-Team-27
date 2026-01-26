% logreader.m
% Use this script to read data from your micro SD card

clear;
%clf;

filenum = '004'; % file number for the data you want to read
infofile = strcat('INF', filenum, '.TXT');
datafile = strcat('LOG', filenum, '.BIN');

%% map from datatype to length in bytes
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

%% read from info file to get log file structure
fileID = fopen(infofile);
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);
[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end
R = cell(1,numel(varNames));

%% read column-by-column from datafile
fid = fopen(datafile,'rb');
for i=1:numel(varTypes)
    %# seek to the first field of the first record
    fseek(fid, sum(varLengths(1:i-1)), 'bof');
    
    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
    eval(strcat(varNames{i},'=','R{',num2str(i),'};'));
end
fclose(fid);

%% Process your data here

%Acceleration plot calculations
confLev = 0.95;
xbar = mean(accelZ); %Arthimatic mean
S = std(accelZ); %Standard deviation
N = length(accelZ); %Dataset sample count
ESE = S/sqrt(N); %Estimated standard error
StdT = tinv( (1-0.5*(1-confLev)), N-1); %Student error
lambda = StdT*ESE; %1/2 of the confidence interval

disp('Arthimatic mean');
disp(xbar)
disp('Standard deviation');
disp(S)
disp('Estimated standard error');
disp(ESE)
disp('Confidence interval bounds');
disp(lambda)

%Generate acceleration plots for acclerometer calibration 
figure('Name', 'Zero X');
plot(accelX, 'red', 'LineWidth', 1); 
hold on;
title('Zero X');
xlabel('Time [samples]');
ylabel('Acceleration [m/s^2]');
grid on;

figure('Name', 'Zero Y');
plot(accelY, 'green', 'LineWidth', 1); 
hold on;
title('Zero Y');
xlabel('Time [samples]');
ylabel('Acceleration [m/s^2]');
grid on;

figure('Name', 'Zero Z');
plot(accelZ, 'blue', 'LineWidth', 1); 
hold on;
title('Zero Z');
xlabel('Time [samples]');
ylabel('Acceleration [m/s^2]');
grid on;

figure('Name', 'Accelerated  Z');
plot(accelZ, 'blue', 'LineWidth', 1); 
hold on;
title('Accelerated Z');
xlabel('Time [samples]');
ylabel('Acceleration [m/s^2]');
grid on;