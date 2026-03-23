% MATLAB Script: Drag Force and Drag Coefficient vs. Reynolds Number
clear; clc; close all;

Re_comsol = [49019.6, 147058.8, 245098.0, 343137.3, 441176.5]; 

% drag simulated
drag_sim_nose1 = [0.022609, 0.20256, 0.56216, 1.1014, 1.8203]; 
drag_sim_nose2 = [0.01638, 0.14625, 0.4058, 0.79496, 1.3137]; 
drag_sim_nose3 = [0.01456, 0.13015, 0.36104, 0.70723, 1.1687]; 

% Cd simualted
cd_sim_nose1 = [0.80747, 0.80381, 0.80309, 0.80278, 0.80261]; 
cd_sim_nose2 = [0.58500, 0.58036, 0.57972, 0.57942, 0.57924];   
cd_sim_nose3 = [0.52000, 0.51647, 0.51577, 0.51548, 0.51530];   

% Reynolds Numbers corresponding to your fan speeds
Re_exp = [79058.82353, 105088.2353, 131117.6471, 157147.0588, 183176.4706, 209205.8824, 235235.2941, 261264.7059, 287294.1176]; 

% drag measured
drag_exp_nose1 = [0.06864655, 0.0588399, 0.196133, 0.2549729, 0.36284605, 0.48052585, 0.61781895, 0.75511205, 0.9414384]; 
drag_exp_nose2 = [0.02941995, 0.02941995, 0.04903325, 0.0784532, 0.1372931, 0.1569064, 0.2157463, 0.2549729, 0.3138128];
drag_exp_nose3 = [0.04903325, 0.0588399, 0.08825985, 0.1176798, 0.1765197, 0.196133, 0.26477955, 0.3334261, 0.4118793]; 

% cd measured
cd_exp_nose1 = [0.942545974, 0.4572442465, 0.979068096, 0.8860659161, 0.9280418213, 0.9422225504, 0.9581660556, 0.9493676576, 0.9788653659]; 
cd_exp_nose2 = [0.4039482746, 0.2286221232, 0.244767024, 0.2726356665, 0.3511509594, 0.3076645063, 0.3345976702, 0.3205657026, 0.3262884553];   
cd_exp_nose3 = [0.6732471243, 0.4572442465, 0.4405806432, 0.4089534997, 0.451479805, 0.3845806328, 0.4106425953, 0.4192013034, 0.4282535976];   

%plot
figure('Name', 'Drag Force vs Reynolds Number', 'Color', 'w', 'Position', [100, 100, 800, 500]);
hold on; grid on;

% Nose 1 (Flat)
plot(Re_comsol, drag_sim_nose1, 'b-', 'LineWidth', 2, 'DisplayName', 'Nose 1 (Sim)');
plot(Re_exp, drag_exp_nose1, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b', 'DisplayName', 'Nose 1 (Meas)');

% Nose 2 (Round)
plot(Re_comsol, drag_sim_nose2, 'r-', 'LineWidth', 2, 'DisplayName', 'Nose 2 (Sim)');
plot(Re_exp, drag_exp_nose2, 'rs', 'MarkerSize', 5, 'MarkerFaceColor', 'r', 'DisplayName', 'Nose 2 (Meas)');

% Nose 3 (Cone)
plot(Re_comsol, drag_sim_nose3, 'g-', 'LineWidth', 2, 'DisplayName', 'Nose 3 (Sim)');
plot(Re_exp, drag_exp_nose3, 'g^', 'MarkerSize', 5, 'MarkerFaceColor', 'g', 'DisplayName', 'Nose 3 (Meas)');

title('Measured and Simulated Drag Force vs. Reynolds Number', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Reynolds Number', 'FontSize', 10);
ylabel('Drag Force (N)', 'FontSize', 10);
legend('Location', 'northwest', 'FontSize', 10);
set(gca, 'FontSize', 10, 'LineWidth', 1);
hold off;

%% 4. Graph 2: Coefficient of Drag vs. Reynolds Number
figure('Name', 'Coefficient of Drag vs Reynolds Number', 'Color', 'w', 'Position', [150, 150, 800, 500]);
hold on; grid on;

% Nose 1 (Flat)
plot(Re_comsol, cd_sim_nose1, 'b-', 'LineWidth', 2, 'DisplayName', 'Nose 1 (Sim)');
plot(Re_exp, cd_exp_nose1, 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b', 'DisplayName', 'Nose 1 (Meas)');

% Nose 2 (Round)
plot(Re_comsol, cd_sim_nose2, 'r-', 'LineWidth', 2, 'DisplayName', 'Nose 2 (Sim)');
plot(Re_exp, cd_exp_nose2, 'rs', 'MarkerSize', 5, 'MarkerFaceColor', 'r', 'DisplayName', 'Nose 2 (Meas)');

% Nose 3 (Cone)
plot(Re_comsol, cd_sim_nose3, 'g-', 'LineWidth', 2, 'DisplayName', 'Nose 3 (Sim)');
plot(Re_exp, cd_exp_nose3, 'g^', 'MarkerSize', 5, 'MarkerFaceColor', 'g', 'DisplayName', 'Nose 3 (Meas)');

title('Measured and Simulated Coefficient of Drag vs. Reynolds Number', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Reynolds Number', 'FontSize', 10);
ylabel('Coefficient of Drag (C_d)', 'FontSize', 10);
legend('Location', 'northeast', 'FontSize', 10);
set(gca, 'FontSize', 10, 'LineWidth', 1);
hold off;