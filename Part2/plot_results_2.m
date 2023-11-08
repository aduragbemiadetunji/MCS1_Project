close all

saveFigures = false; % Set to true to save figures
saveDirectory = 'test'; % Update with your path
commonFontSize = 12;


%%Controller Force
controllerForceFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Controller_force.Time, Controller_force.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Controller Force Plot for Tau_x', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_x (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_x'}, 'FontSize', commonFontSize)
set(gca, 'FontSize', commonFontSize)


% Second subplot for Tau_y
subplot(3, 1, 2) % 3 rows, 1 column, second subplot
plot(Controller_force.Time, Controller_force.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright green
title('Controller Force Plot for Tau_y', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_y (N)', 'FontSize', commonFontSize) 
grid on
legend({'Tau_y'}, 'FontSize', commonFontSize)


% Third subplot for Tau_yaw
subplot(3, 1, 3) % 3 rows, 1 column, third subplot
plot(Controller_force.Time, Controller_force.Data(:,6), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright blue
title('Controller Force Plot for Tau_{yaw}', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_{yaw} (Nm)', 'FontSize', commonFontSize) 
grid on
legend({'Tau_{yaw}'}, 'FontSize', commonFontSize)

if saveFigures
    controllerForcePath = fullfile(saveDirectory, 'ControllerForcePlot.png');
    print(controllerForceFigure, controllerForcePath, '-dpng', '-r300'); 
end

% Adjust the overall font size of the axes labels


%%Thruster Force
thrusterForceFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(5, 1, 1) % 3 rows, 1 column, first subplot
plot(Thruster_force.Time, Thruster_force.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thruster Force Plot for Thruster 1', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_1 (N)', 'FontSize', commonFontSize)
grid on
legend({'F_1'}, 'FontSize', commonFontSize)

subplot(5, 1, 2) % 3 rows, 1 column, first subplot
plot(Thruster_force.Time, Thruster_force.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thruster Force Plot for Thruster 2', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_2 (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_2'}, 'FontSize', commonFontSize)

subplot(5, 1, 3) % 3 rows, 1 column, first subplot
plot(Thruster_force.Time, Thruster_force.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thruster Force Plot for Thruster 3', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_3 (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_1'}, 'FontSize', commonFontSize)

subplot(5, 1, 4) % 3 rows, 1 column, first subplot
plot(Thruster_force.Time, Thruster_force.Data(:,4), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thruster Force Plot for Thruster 4', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_4 (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_4'}, 'FontSize', commonFontSize)


subplot(5, 1, 5) % 3 rows, 1 column, first subplot
plot(Thruster_force.Time, Thruster_force.Data(:,5), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thruster Force Plot for Thruster 5', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_5 (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_5'}, 'FontSize', commonFontSize)
% Save the Thruster Force figure
if saveFigures
    thrusterForcePath = fullfile(saveDirectory, 'ThrusterForcePlot.png');
    print(thrusterForceFigure, thrusterForcePath, '-dpng', '-r300'); 
end

%%Thrust Dynamics
thrustDynamicsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Thrust_dynamic_force.Time, Thrust_dynamic_force.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Thrust Dynamic Force Plot for Tau_x', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_x (N)', 'FontSize', commonFontSize) 
grid on
legend({'F_x'}, 'FontSize', commonFontSize)

% Second subplot for Tau_y
subplot(3, 1, 2) % 3 rows, 1 column, second subplot
plot(Thrust_dynamic_force.Time, Thrust_dynamic_force.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright green
title('Thrust Dynamic Force Plot for Tau_y', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_y (N)', 'FontSize', commonFontSize) 
grid on
legend({'Tau_y'}, 'FontSize', commonFontSize)

% Third subplot for Tau_yaw
subplot(3, 1, 3) % 3 rows, 1 column, third subplot
plot(Thrust_dynamic_force.Time, Thrust_dynamic_force.Data(:,6), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright blue
title('Thrust Dynamic Force Plot for Tau_{yaw}', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('F_{yaw} (Nm)', 'FontSize', commonFontSize) 
grid on
legend({'Tau_{yaw}'}, 'FontSize', commonFontSize)
% Save the Thrust Dynamics figure
if saveFigures
    thrustDynamicsPath = fullfile(saveDirectory, 'ThrustDynamicsPlot.png');
    print(thrustDynamicsFigure, thrustDynamicsPath, '-dpng', '-r300'); 
end


% Eta Plots
etaPlotsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and reference position in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surgae (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge', 'surge_sp'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and reference position in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway', 'sway_sp'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Orientation and reference orientation in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw (rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw', 'yaw_sp'}, 'FontSize', commonFontSize)

if saveFigures
    etaPlotsPath = fullfile(saveDirectory, 'EtaPlot.png');
    print(etaPlotsFigure, etaPlotsPath, '-dpng', '-r300'); 
end


%%XY Plot
xyPlotFigure = figure('Position', [100, 100, 800, 800])
plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0])
hold on
plot(Eta_sp.Data(:,1),Eta_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1])
legend({'Position', 'Position SP'})
grid on
title('XY plot')
xlabel('North (m)')
ylabel('East (m)')

% Save the XY Plot
if saveFigures
    xyPlotPath = fullfile(saveDirectory, 'XYPlot.png');
    print(xyPlotFigure, xyPlotPath, '-dpng', '-r300'); 
end



