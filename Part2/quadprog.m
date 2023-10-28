function [Td, alpha] = quadprog(tau_dp)
%% x, y, and psi component of tau_d
tau = [tau_dp(1); tau_dp(2); tau_dp(6)]; 

%% Quadratic Programming
% Compute function arguments
% Point to Minimize
u_p = [1 1 1 1 1 1 1 1].'; % [T1 T2x T2y T3 T4x T4y T5x T5y]
u_m = -[1 1 1 1 1 1 1 1].'; % [T1 T2x T2y T3 T4x T4y T5x T5y]
s_p = [0.1 0.1 0.1].'; % [x1 x2 x6]
s_m = -[0.1 0.1 0.1].'; % [x1 x2 x6]
alph_p = [1 1 1]; % [alpha2 alpha4 alpha5]
alph_m = -[1 1 1]; % [alpha2 alpha4 alpha5]
x0 = [u_p; u_m; s_p; s_m; alph_p; alph_m]; % auxiliary variables

% Objective Function
% Quadratic Objective Term
w = [1 1 1 1 100 100 100 100]; % Prioritize control over T4 and T5
q = [1 1 1]; % For slackness (Needs Tuning)
w_alpha = [0 10 10]; % Importance on thruster 4 and thruster 5
H = 2*diag([w.' w.' q.' q.' w_alpha.' w_alpha.']);

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

Aeq = [B_redistributed -B_redistributed eye(3) -eye(3) 0 0];
beq = tau;

% Thruster Saturation Constraints
u_max = [125 150 125 300 300].';
u_min = -[125 150 125 300 300].';

% Thruster Rate Limitation Constraints
delta_u_max = [8 8 8 10 10].'; % In second
delta_u_min = -[8 8 8 10 10].'; % In second
u_limit = [5 5 5 5 5]; % To be tuned (?) [Thruster rate (0-100%) second]

% Forbiden Sector for Azimuth Thruster (T2, T4, T5)
forb_sector = 20/180 *(2*pi); % 20 degrees

alpha4_max = -pi/2 + forb_sector/2;
alpha4_min = -pi/2 - forb_sector/2;

alpha5_max = pi/2 + forb_sector/2;
alpha5_min = pi/2 - forb_sector/2;

alpha_max = [2*pi alpha4_max alpha5_max].';
alpha_min = [0 alpha4_min alpha5_min].';

% Rate Limitation for Azimuth Thruster Angle [rpm]
delta_a_max = [2 2 2]; 
delta_a_min = -[2 2 2];
alpha_limit = [0.2 0.2 0.2];

A = [eye(5) -eye(5) 0 0 eye(3) -eye(3);
     -eye(5) eye(5) 0 0 -eye(3) eye(3)];

b = [max(u_min, delta_min+u_limit, delta_a_min+alpha_limit);
     -min(u_max, delta_max-u_limit, delta_a_max-alpha_limit)];

% Upper and Lower Boundary
lb = [];

ub = [];

% Compute optimal thruster control
x0_opt = quadprog(H,f,A,b,Aeq,beq,x0);
% x0_opt = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0);

% Slack Variable from auxiliary variables
s = x0_opt(17:19) - x0_opt(20:22); % STILL DON'T NOW WHAT TO DO WITH THIS
s_abs = x0_opt(17:19) + x0_opt(20:22); % STILL DON'T NOW WHAT TO DO WITH THIS

% Allocation variables from auxiliary variables
u = x0_opt[1:8] - xo_opt[9:16]; % STILL DON'T NOW WHAT TO DO WITH THIS
u_abs = x0_opt[1:8] + xo_opt[9:16]; % STILL DON'T NOW WHAT TO DO WITH THIS

alpha = x0_opt(23:25) - xo_opt(26:28); % STILL DON'T NOW WHAT TO DO WITH THIS
alpha_abs = x0_opt(23:25) - xo_opt(26:28); % STILL DON'T NOW WHAT TO DO WITH THIS

%% RESULTS
Td = [u(1); 
      sqrt(u(2)^2 + u(3)^2); 
      u(4); 
      sqrt(u(5)^2 + u(6)^2);
      sqrt(ub(7)^2 + u(8)^2)];

alpha2 = atan(u(3)/u(2));
alpha4 = atan(u(6)/u(5));
alpha5 = atan(u(8)/u(7));
alpha = [alpha2; alpha4; alpha5];

%QUESTION
% what is u plus, u minus, s plus, s minus?
% f is empty?
% How to determine w and q? How do they normally look like?
% u max, u min, delta max, delta min, u limit?
% lower boundary, upper boundary
% Where to implement Rotation on the table?

% %% Pseudo inverse [JUST A DIFFERENT METHOD]
% % Compute B redistributed
% thr1 = [0 1 39.3].';
% thr2_x = [0 1 35.6].';
% thr2_y = [1 0 35.6].';
% thr3 = [0 1 31.3].';
% thr4_x = [0 1 -28.5].';
% thr4_y = [1 0 5].';
% thr5_x = [0 1 -28.5].';
% thr5_y = [1 0 -5].';
% 
% B_redistributed = [thr1 thr2_x thr2_y thr3 thr4_x thr4_y thr5_x thr5_y];
% 
% Td_r = pinv(B_redistributed) * tau_r;
% Td = [Td_r(1); 
%            sqrt(Td_r(2)^2+Td_r(3)^2); 
%            tau_r(4); 
%            sqrt(Td_r(5)^2+Td_r(6)^2);
%            sqrt(Td_r(7)^2+Td_r(8)^2)];
% 
% alpha2 = atan(Td(3)/Td(2));
% alpha4 = atan(Td(6)/Td(5));
% alpha5 = atan(Td(8)/Td(7));
% alpha = [alpha2; alpha4; alpha5];

end