close all

figure(1)
plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2)
hold on
plot(Eta_sp.Data(:,1),Eta_sp.Data(:,2), 'LineWidth', 2)
legend({'Controller', 'Reference'})
grid on
title('XY plot')
xlabel('North (m)')
ylabel('East (m)')

hold off

figure(2)
plot(Current.Time, Current.Data, 'LineWidth', 2)
hold on
% plot(Current.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Current.Data(:,3), 'LineWidth', 2)
legend({'Current_x', 'Current_y', 'Current_{yaw}'})
grid on
title('Current Plot')
xlabel('Time')
ylabel('Current(m/s)')
hold off

figure(3)
plot(Eta.Time, Eta.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'Eta_x', 'Eta_y', 'Eta_{yaw}'})
grid on
ylim([-10 20])
title('Eta Plot')
xlabel('Time')
ylabel('EtaPlot(m, m, rad)')


figure(4)
plot(Eta_sp.Time, Eta_sp.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'Eta_{sp_x}', 'Eta_{sp_y}', 'Eta_{sp-yaw}'})
grid on
ylim([-10 20])
% xlim([0 2000])
title('Eta_{sp} Plot')
xlabel('Time')
ylabel('Eta_{sp}(m, m, rad)')



figure(5)
plot(Eta_sp.Time, Eta_sp.Data - Eta.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'Error_x', 'Error_y', 'Error_{yaw}'})
grid on
% xlim([0 2000])
title('Error Plot')
xlabel('Time')
ylabel('Error(m, m, rad)')



figure(6)
plot(Tau.Time, Tau.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'Tau_x', 'Tau_y', 'Tau_{yaw}'})
grid on
% xlim([0 2000])
title('Tau Plot')
xlabel('Time')
ylabel('Tau(N, N, Nm)')


figure(7)
plot(nu.Time, nu.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'nu_x', 'nu_y', 'nu_{yaw}'})
grid on
% xlim([0 2000])
title('Velocity Plot')
xlabel('Time')
ylabel('Velocity m/s')


figure(8)
plot(nu_sp.Time, nu_sp.Data, 'LineWidth', 2)
hold on
% plot(Eta.Data(:,2), 'LineWidth', 2)
% hold on
% plot(Eta.Data(:,3), 'LineWidth', 2)
legend({'nu_x SP', 'nu_y SP', 'nu_{yaw} SP'})
grid on
% xlim([0 2000])
title('Reference Velocity Plot')
xlabel('Time')
ylabel('Velocity m/s')

