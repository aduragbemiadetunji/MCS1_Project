function [Td, alpha] = p_inv_B(tau_d)
%% Build the B matrix
% Thruster 1
x1 = 39.3;
y1 = 0;
% Thruster 2
x2 = 35.6;
y2 = 0;
% Thruster 3
x3 = 31.3;
y3 = 0;
% Thruster 4
x4 = -28.5;
y4 = 5;
% Thruster 5
x5 = -28.5;
y5 = -5;

% Redistributed force for each thruster
thr1 = [0 1 x1].';
thr2_x = [1 0 y2].';
thr2_y = [0 1 x2].';
thr3 = [0 1 x3].';
thr4_x = [1 0 y4].';
thr4_y = [0 1 x4].';
thr5_x = [1 0 y5].';
thr5_y = [0 1 x5].';

% B redistributed
B = [thr1 thr2_x thr2_y thr3 thr4_x thr4_y thr5_x thr5_y];

%% Result
tau = [tau_d(1); tau_d(2); tau_d(6)];

Td_r = pinv(B) * tau;

% Thruster control
Td = [Td_r(1); 
      sqrt(Td_r(2)^2 + Td_r(3)^2); 
      Td_r(4); 
      sqrt(Td_r(5)^2 + Td_r(6)^2);
      sqrt(Td_r(7)^2 + Td_r(8)^2)];

alpha2 = atan2(Td_r(3),Td_r(2));
alpha4 = atan2(Td_r(6),Td_r(5));
alpha5 = atan2(Td_r(8),Td_r(7));

%% CONSTRAIN 1 - Saturation Limit

alpha = [pi/2; alpha2; pi/2; alpha4; alpha5];
end