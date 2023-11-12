close all

saveFigures = false; % Set to true to save figures
saveDirectory = 'test'; % Update with your path
commonFontSize = 12;

% Eta Plots
etaPlotsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(Eta_obs.Time, Eta_obs.Data(:,1), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Position, observer position and reference position in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge', 'surge sp', 'surge obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(Eta_obs.Time, Eta_obs.Data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Position, observer position and reference position in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway', 'sway sp', 'sway obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_sp.Time, Eta_sp.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(Eta_obs.Time, Eta_obs.Data(:,3), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Orientation, observer orientation and reference orientation in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw (rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw', 'yaw sp', 'yaw obs'}, 'FontSize', commonFontSize)

if saveFigures
    etaPlotsPath = fullfile(saveDirectory, 'EtaPlot.png');
    print(etaPlotsFigure, etaPlotsPath, '-dpng', '-r300'); 
end


% Error Plots
errorPlotsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta_sp.Time, Eta_sp.Data(:,1) - Eta.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position error in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge error (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge error'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta_sp.Time, Eta_sp.Data(:,2) - Eta.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position error in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway error (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway error'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta_sp.Time, Eta_sp.Data(:,3)- Eta.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Orientation error in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw error(rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw error'}, 'FontSize', commonFontSize)

if saveFigures
    errorPlotsPath = fullfile(saveDirectory, 'ErrorPlot.png');
    print(errorPlotsFigure, errorPlotsPath, '-dpng', '-r300'); 
end



% Velocity Plots
nuPlotsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_sp.Time, nu_sp.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(nu_obs.Time, nu_obs.Data(:,1), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Velocity, observer velocity and reference velocity in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'surge velocity', 'surge sp velocity', 'surge obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_sp.Time, nu_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(nu_obs.Time, nu_obs.Data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Velocity, observer velocity and reference velocity in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'sway velocity', 'sway sp velocity', 'sway obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_sp.Time, nu_sp.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
hold on
plot(nu_obs.Time, nu_obs.Data(:,3), 'LineWidth', 2, 'Color', [0, 1, 0]) % bright red
title('Velocity, observer velocity and reference velocity in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw velocity (rad/s)', 'FontSize', commonFontSize) 
grid on
legend({'yaw velocity', 'yaw sp velocity', 'yaw obs velocity'}, 'FontSize', commonFontSize)

if saveFigures
    nuPlotsPath = fullfile(saveDirectory, 'nuPlot.png');
    print(nuPlotsFigure, nuPlotsPath, '-dpng', '-r300'); 
end



%%XY Plot
% xyPlotFigure = figure('Position', [100, 100, 800, 800])
% plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0])
% hold on
% plot(Eta_sp.Data(:,1),Eta_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1])
% hold on
% plot(Eta_obs.Data(:,1),Eta_obs.Data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0])
% legend({'Position', 'Position SP', 'Position OBS'})
% grid on
% title('XY plot')
% xlabel('North (m)')
% ylabel('East (m)')

%%XY Plot
xyPlotFigure = figure('Position', [100, 100, 800, 800])
plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0])
hold on
plot(Eta_sp.Data(:,1),Eta_sp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1])
hold on
x = Eta.Data(:,1);
y = Eta.Data(:,2);
psi = Eta.Data(:,3);
plot(Eta_obs.Data(:,1),Eta_obs.Data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0])
quiver(x(1:1000:end),y(1:1000:end), 0.0001*cos(psi(1:1000:end)), 0.0001*sin(psi(1:1000:end)) ,'k','AutoScale','on');
legend({'Position', 'Position SP', 'Position OBS', 'Vessel Heading'})
grid on
title('XY plot with Heading')
xlabel('North (m)')
ylabel('East (m)')

% Save the XY Plot
if saveFigures
    xyPlotPath = fullfile(saveDirectory, 'XYPlot.png');
    print(xyPlotFigure, xyPlotPath, '-dpng', '-r300'); 
end



