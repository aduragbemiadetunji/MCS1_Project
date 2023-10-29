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
tau = [tau_d(1); tau_d(2); tau_d(6)];

Td_r = pinv(B) * tau;

Td = [Td_r(1); 
      sqrt(Td_r(2)^2 + Td_r(3)^2); 
      Td_r(4); 
      sqrt(Td_r(5)^2 + Td_r(6)^2);
      sqrt(Td_r(7)^2 + Td_r(8)^2)];

alpha2 = atan(Td_r(3)/Td_r(2));
alpha4 = atan(Td_r(6)/Td_r(5));
alpha5 = atan(Td_r(8)/Td_r(7));
alpha = [0; alpha2; 0; alpha4; alpha5];

end