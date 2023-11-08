close all
%sim part2_MAIN.slx

figure(1)
plot(Eta.Data(:,1),Eta.Data(:,2), 'LineWidth', 2)
hold on
grid on
title('XY plot')
xlabel('North (m)')
ylabel('East (m)')

hold off

%Eta.Data(:,3) = Eta.Data(:,3)*(180/pi);

figure(2)
plot(Eta.Time, Eta.Data, 'LineWidth', 2)
hold on
legend({'Eta_x', 'Eta_y', 'Eta_{yaw}'})
grid on
ylim([-100 100])
title('Eta Plot')
xlabel('Time')
ylabel('EtaPlot(m, m, degrees)')



