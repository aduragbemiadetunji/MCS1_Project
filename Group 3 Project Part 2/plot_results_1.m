close all

saveFigures = false; % Set to true to save figures
saveDirectory = 'sim1'; % Update with your path
commonFontSize = 12;

% Eta Plots
etaPlotsFigure = figure('Position', [100, 100, 600, 800])
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Position in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Position in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
title('Orientation in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw (rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw'}, 'FontSize', commonFontSize)

if saveFigures
    etaPlotsPath = fullfile(saveDirectory, 'EtaPlot.png');
    print(etaPlotsFigure, etaPlotsPath, '-dpng', '-r300'); 
end

% %%XY Plot
% xyPlotFigure = figure('Position', [100, 100, 800, 800])
% plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0])
% legend({'Position'})
% grid on
% title('XY plot')
% xlabel('North (m)')
% ylabel('East (m)')


%%XY Plot
xyPlotFigure = figure('Position', [100, 100, 800, 800])
plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1])
hold on
x = Eta.Data(:,1);
y = Eta.Data(:,2);
psi = Eta.Data(:,3);
% plot(Eta_obs.Data(:,1),Eta_obs.Data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0])
quiver(x(1:1000:end),y(1:1000:end), 0.0001*cos(psi(1:1000:end)), 0.0001*sin(psi(1:1000:end)) ,'k','AutoScale','on');
legend({'Position', 'Vessel Heading'})
grid on
title('XY plot with Heading')
xlabel('North (m)')
ylabel('East (m)')


% Save the XY Plot
if saveFigures
    xyPlotPath = fullfile(saveDirectory, 'XYPlot.png');
    print(xyPlotFigure, xyPlotPath, '-dpng', '-r300'); 
end



