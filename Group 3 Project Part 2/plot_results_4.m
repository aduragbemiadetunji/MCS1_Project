close all

saveFigures = false; % Set to true to save figures
saveDirectory = 'result_4/with_wave/'; % Update with your path
commonFontSize = 12;


% Eta Plots
etaPlotsFigure_ekf = figure('Position', [100, 100, 600, 800]);
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_ekf.Time, Eta_obs_ekf.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and observer position in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge', 'surge obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_ekf.Time, Eta_obs_ekf.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and observer position in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway', 'sway obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_ekf.Time, Eta_obs_ekf.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Orientation and observer orientation in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw (rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw', 'yaw obs'}, 'FontSize', commonFontSize)

if saveFigures
    etaPlotsPath = fullfile(saveDirectory, 'EtaPlot_EKF.png');
    print(etaPlotsFigure_ekf, etaPlotsPath, '-dpng', '-r300'); 
end



% Velocity Plots
nuPlotsFigure_ekf = figure('Position', [100, 100, 600, 800]);
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_ekf.Time, nu_obs_ekf.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'surge velocity', 'surge obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_ekf.Time, nu_obs_ekf.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity  in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'sway velocity', 'sway obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_ekf.Time, nu_obs_ekf.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw velocity (rad/s)', 'FontSize', commonFontSize) 
grid on
legend({'yaw velocity', 'yaw obs velocity'}, 'FontSize', commonFontSize)

if saveFigures
    nuPlotsPath = fullfile(saveDirectory, 'nuPlot_ekf.png');
    print(nuPlotsFigure_ekf, nuPlotsPath, '-dpng', '-r300'); 
end


%nlp
% Eta Plots
etaPlotsFigure_nlp = figure('Position', [100, 100, 600, 800]);
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_nlp.Time, Eta_obs_nlp.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and observer position in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge (m)', 'FontSize', commonFontSize) 
grid on
legend({'surge', 'surge obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_nlp.Time, Eta_obs_nlp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Position and observer position in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway (m)', 'FontSize', commonFontSize) 
grid on
legend({'sway', 'sway obs'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(Eta.Time, Eta.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(Eta_obs_nlp.Time, Eta_obs_nlp.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Orientation and observer orientation in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw (rad)', 'FontSize', commonFontSize) 
grid on
legend({'yaw', 'yaw obs'}, 'FontSize', commonFontSize)

if saveFigures
    etaPlotsPath = fullfile(saveDirectory, 'EtaPlot_NLP.png');
    print(etaPlotsFigure_nlp, etaPlotsPath, '-dpng', '-r300'); 
end



% Velocity Plots
nuPlotsFigure_nlp = figure('Position', [100, 100, 600, 800]);
% First subplot for Tau_x
subplot(3, 1, 1) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,1), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_nlp.Time, nu_obs_nlp.Data(:,1), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity in surge', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Surge velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'surge velocity', 'surge obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 2) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,2), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_nlp.Time, nu_obs_nlp.Data(:,2), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity  in sway', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Sway velocity (m/s)', 'FontSize', commonFontSize) 
grid on
legend({'sway velocity', 'sway obs velocity'}, 'FontSize', commonFontSize)

subplot(3, 1, 3) % 3 rows, 1 column, first subplot
plot(nu.Time, nu.Data(:,3), 'LineWidth', 2, 'Color', [1, 0, 0]) % bright red
hold on
plot(nu_obs_nlp.Time, nu_obs_nlp.Data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1]) % bright red
title('Velocity and observer velocity in yaw', 'FontSize', commonFontSize)
xlabel('Time(s)', 'FontSize', commonFontSize)
ylabel('Yaw velocity (rad/s)', 'FontSize', commonFontSize) 
grid on
legend({'yaw velocity', 'yaw obs velocity'}, 'FontSize', commonFontSize)

if saveFigures
    nuPlotsPath = fullfile(saveDirectory, 'nuPlot_nlp.png');
    print(nuPlotsFigure_nlp, nuPlotsPath, '-dpng', '-r300'); 
end



