%Lachlan McDermott
%E80 Lab 4
%2/10/2026
%Linear Regression Script

%intake data and do linear regression

turbidity = [1.925; 1.74; 1.527; 1.321; 1.11]; % voltage 
ratio     = [0; -0.1; -0.2; -0.3; -0.4]; % depth

graph = fitlm(turbidity, ratio);
intercept = graph.Coefficients.Estimate(1);
slope     = graph.Coefficients.Estimate(2);
intercept_se = graph.Coefficients.SE(1);
r_sq      = graph.Rsquared.Ordinary;

xGrid = linspace(min(turbidity), max(turbidity), 100)';
yFit = predict(graph, xGrid);

[~, ci_functional] = predict(graph, xGrid, 'Prediction', 'curve', 'Alpha', 0.05);
[~, ci_observational] = predict(graph, xGrid, 'Prediction', 'observation', 'Alpha', 0.05);

figure('Color', 'w'); 
hold on; 
grid on;

fill([xGrid; flipud(xGrid)], [ci_observational(:,1); flipud(ci_observational(:,2))], [0.5 1 1], 'EdgeColor', 'none');

fill([xGrid; flipud(xGrid)], [ci_functional(:,1); flipud(ci_functional(:,2))], [0.8 1 1], 'EdgeColor', 'none');

plot(xGrid, yFit, 'b-', 'LineWidth', 1.5);
plot(turbidity, ratio, 'ks', 'MarkerFaceColor', 'k');

xlabel('Voltage [V]');
ylabel('Depth [m]');
title('Voltage vs. Depth');
legend('Observational Bounds', 'Functional Bounds', 'Line of Best Fit', 'Data', 'Location', 'southeast');

stats_str = {sprintf('Equation: y = %.5f * x + %.5f', slope, intercept);
             sprintf('Intercept: %.5f ± %.5f', intercept, intercept_se);
             sprintf('Slope: %.5e', slope);
             sprintf('R-Square: %.5f', r_sq);};

annotation('textbox', [0.15, 0.7, 0.3, 0.15], 'String', stats_str, ...
           'FitBoxToText', ...
           'on', ...
           'BackgroundColor', ...
           'white', ...
           'EdgeColor', ...
           'black');
hold off;