function [u,alpha] = thrust_alloc(tau_d)
% Thrusters' angle
alpha2 = 0;
alpha4 = 0;
alpha5 = 0;

% x, y, and psi component of tau_d
tau_db = [tau_d(1); tau_d(2); tau_d(6)];

% Pseudo inverse
u = pinv(B(alpha2, alpha4, alpha5)) * tau_db;
alpha = [alpha2; alpha4; alpha5];
end