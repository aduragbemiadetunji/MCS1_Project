clear
clc
%% TESTING ONLY
tau = [100; -50; 0; 0; 0; 0];

% B redistributed pseudo inverse
[Td_br, alpha_br] = p_inv_B(tau)

% Quadratic Programming basic
[Td_qp, alpha_qp] = quad_prog_basic(tau)