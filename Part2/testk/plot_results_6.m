clear
clc
close all

%% UNLOAD DATA
average_thrust_util = zeros(1, 36);
limit = ones(1, (length(average_thrust_util)+1))*3;
average_error_util = zeros(3, 36);

for x = 1:36
    % Load the .mat file
    filename = sprintf('thrust_util/thrust_util_%d.mat', x);
    load(filename);

    % Calculate the average thrust_util
    average_thrust_util(x) = mean(thrust_util / 10);
    average_error_util(:, x) = mean(error_util);
end

% PLOTTING
% Unconstrained Radial Plot
figure(1)
average_thrust_util = [average_thrust_util average_thrust_util(1)];
psi = 2*pi:-10/180*pi:0;  % Reverse the order of psi values

% Create a polar plot
pax = polaraxes;
polarplot(pax, psi, average_thrust_util, 'b', 'LineWidth', 2, 'DisplayName', 'Average thrust utilization (%)');

% Adjust the polar plot settings
pax.ThetaZeroLocation = 'top';  % Zero degrees point upwards
pax.ThetaDir = 'clockwise';    % Angle increases clockwise

% Add a grid
rlim([0 100]);  % Adjust the radial limit
rticks(0:10:100);  % Set radial ticks
thetaticks(0:10:360);  % Set angular ticks at 10-degree increments

% Add a title
title('Average Thrust Utilization Plot');

% Add a legend with a custom label and specify its position
lgd = legend('Average thrust utilization (%)', 'Location', 'southoutside');


% PLOTTING ERROR
figure(2)
plot(psi, [average_error_util(1,:), average_error_util(1,1)], 'r', 'LineWidth', 2, 'DisplayName', 'X Position Error');
hold on
plot(psi, [average_error_util(2,:), average_error_util(2,1)], 'g', 'LineWidth', 2, 'DisplayName', 'Y Position Error');
hold on
plot(psi, [rad2deg(average_error_util(3,:)), rad2deg(average_error_util(3,1))], 'b', 'LineWidth', 2, 'DisplayName', 'Psi Angle Error');
hold on
plot(psi, limit, 'k--', 'LineWidth', 1, 'DisplayName', 'Position and Angle Deviation Limit');
plot(psi, -limit, 'k--', 'LineWidth', 1);
legend('X Position Error [m]', 'Y Position Error [m]', 'Psi Angle Error [degree]', 'Position and Angle Deviation Limit [m & degree]');
xlim([0 2*pi]);
xlabel('Incident Angle in Radian')
ylim([-4 4]);
yticks(-4:0.5:4);
ylabel('Deviation Error in Meter and Degree')
title('Deviation Error of Capability Plot')
hold on
grid on


%% COMPARISON PLOT
figure(3)
pinv = load("compare/thrust_pinv_10.mat");
qp = load("compare/thrust_qp_10.mat");

pinv_av = mean(pinv.thrust_util.Data(:,1)*100);
qp_av = mean(qp.thrust_util.Data(:,1)/10);

plot(pinv.thrust_util.Time, pinv.thrust_util.Data(:,1))
hold on
plot(qp.thrust_util.Time, (qp.thrust_util.Data(:,1)/1000))
hold on
legend('Pseudo-Inverse', 'Quadratic Programming')
grid on
title('Comparison of PI & QP Thrust Utilization')
xlabel('Time [s]')
ylabel('Thrust Utilization')
