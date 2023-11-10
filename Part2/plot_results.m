close all

sim("part2_MAIN.slx");

figure(1)
plot(wind_extreme.Time, wind_extreme.Data, 'LineWidth', 0.5)
hold on
legend({'x', 'y', 'z', '\phi', '\theta', '\psi'})
grid on
title('Generalized wind forces')
xlabel('Time')
ylabel('Wind force (N)')

hold off

figure(2)
plot(total_wind.Time, total_wind.Data, 'LineWidth', 0.5)
grid on
title('Total wind')
xlabel('Time')
ylabel('Wind speed (m/s)')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\total_wind");

figure(3)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,1), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'x', '\alpha'})
grid on
title('Generalized wind force in x')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force1");

figure(4)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,2), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'y', '\alpha'})
grid on
title('Generalized wind force in y')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force2");

figure(5)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,3), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'z', '\alpha'})
grid on
title('Generalized wind force in z')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force3");

figure(6)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,4), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'\phi', '\alpha'})
grid on
title('Generalized wind force in \phi')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force4");

figure(7)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,5), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'\theta', '\alpha'})
grid on
title('Generalized wind force in \theta')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force5");

figure(8)
yyaxis left
xlabel('Time')
plot(wind_extreme.Time, wind_extreme.Data(:,6), 'LineWidth', 0.5)
ylabel('Wind force (N)')
hold on
yyaxis right
ylabel('Relative wind angle (rad)')
plot(wind_angle.Time, wind_angle.Data, 'LineWidth', 0.5)
legend({'\psi', '\alpha'})
grid on
title('Generalized wind force in \psi')
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_force6");

close all

mean_wind_direction2 = pi*ones(1,301);

figure(9)
plot(wind_direction.Time, wind_direction.Data, 'LineWidth', 0.5)
hold on
plot(wind_direction.Time, mean_wind_direction2, 'LineWidth', 0.5)
ylabel('Wind direction (rad)')
xlabel('Time')
title('Wind direction')
legend({'wind direction', 'mean wind direction'})
grid on
%print('-dpng','-r600',"C:\Users\mariu\OneDrive\NTNU\Høst 2023\Marin\Project part 2\wind_dir");




