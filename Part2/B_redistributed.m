function [Td, alpha] = B_redistributed(tau_d)
thr1 = [0 1 39.3].';
thr2_x = [0 1 35.6].';
thr2_y = [1 0 35.6].';
thr3 = [0 1 31.3].';
thr4_x = [0 1 -28.5].';
thr4_y = [1 0 5].';
thr5_x = [0 1 -28.5].';
thr5_y = [1 0 -5].';

B = [thr1 thr2_x thr2_y thr3 thr4_x thr4_y thr5_x thr5_y];

% Expected tau_d dimension : 8x1
Td = pinv(B) * tau_d;

alpha2 = atan(Td(3)/Td(2));
alpha4 = atan(Td(6)/Td(5));
alpha5 = atan(Td(8)/Td(7));
alpha = [alpha2; alpha4; alpha5];

end