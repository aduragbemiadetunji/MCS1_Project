function [Td, alpha] = quadprog_basic(tau_d)
%% x, y, and psi component of tau_d
tau = [tau_d(1); tau_d(2); tau_d(6)]; 

%% Quadratic Programming
% Compute function arguments
% Point to Minimize
u_p = [0 0 0 0 0 0 0 0].'; % [T1 T2x T2y T3 T4x T4y T5x T5y]
u_m = -[0 0 0 0 0 0 0 0].'; % [T1 T2x T2y T3 T4x T4y T5x T5y]
s_p = [0 0 0].'; % [x1 x2 x6]
s_m = -[0 0 0].'; % [x1 x2 x6]
x0 = [u_p; u_m; s_p; s_m]; % auxiliary variables

% Objective Function
% Quadratic Objective Term
w = [1 1 1 1 100 100 100 100]; % Prioritize control over T4 and T5
q = [1 10 10]; % For slackness (Needs Tuning)
H = 2*diag([w.' w.' q.' q.']);

% Linear Objective Term
f = []; % No linear term in the objective function

% Thruster Equality Constraints
thr1 = [0 1 39.3].';
thr2_x = [0 1 35.6].';
thr2_y = [1 0 35.6].';
thr3 = [0 1 31.3].';
thr4_x = [0 1 -28.5].';
thr4_y = [1 0 5].';
thr5_x = [0 1 -28.5].';
thr5_y = [1 0 -5].';

B_redistributed = [thr1 thr2_x thr2_y thr3 thr4_x thr4_y thr5_x thr5_y];

Aeq = [B_redistributed -B_redistributed eye(3) -eye(3)];
beq = tau;

% Thruster Saturation Constraints
u_max = [125 150 125 300 300].';
u_min = -[125 150 125 300 300].';

A = [eye(5) -eye(5) 0 0;
     -eye(5) eye(5) 0 0];

b = [max(u_min);
     -min(u_max)];

% b = [max(u_max);
%      -min(u_min)];

% Compute optimal thruster control
x0_opt = quadprog(H,f,A,b,Aeq,beq,x0);

% Slack Variable from auxiliary variables
s = x0_opt(17:19) - x0_opt(20:22); % STILL DON'T NOW WHAT TO DO WITH THIS
s_abs = x0_opt(17:19) + x0_opt(20:22); % STILL DON'T NOW WHAT TO DO WITH THIS

% Allocation variables from auxiliary variables
u = x0_opt(1:8) - xo_opt(9:16); 
u_abs = x0_opt(1:8) + xo_opt(9:16); 

%% RESULTS
Td = [u(1); 
      sqrt(u(2)^2 + u(3)^2); 
      u(4); 
      sqrt(u(5)^2 + u(6)^2);
      sqrt(ub(7)^2 + u(8)^2)];

alpha2 = atan(u(3)/u(2));
alpha4 = atan(u(6)/u(5));
alpha5 = atan(u(8)/u(7));
alpha = [0; alpha2; 0; alpha4; alpha5];