%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% init()                                                                  %
%                                                                         %              
% Set initial parameters for part1.slx and part2.slx                      %
%                                                                         %
% Created:      2018.07.12	Jon Bjørnø                                    %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

load('supply.mat');
load('supplyABC.mat');
load('thrusters_sup.mat')

% Initial position x, y, z, phi, theta, psi
eta0 = [0,0,0,0,0,0]';
% Initial velocity u, v, w, p, q, r
nu0 = [0,0,0,0,0,0]';

%% %% data for reference model
%ti is 1/ti from slide 10
ti = [1/5, 1/5, 1/10]; %good
Af = diag(ti);

omega_is = [0.2, 0.2, 0.2]; %0.1 ish
% omega_is = [2, 3, 4];
zeta_is = [1.5, 1.5, 1.5]; %1.2 ish
% zeta_is = [2, 4, 5];

Gamma = diag(omega_is);
Omega = diag(2*omega_is.*zeta_is);

%number of simulation
simulation = 4;
change_position_time = 400;
%% PID Parameters
Mass = diag([vesselABC.MRB(1,1), vesselABC.MRB(2,2), vesselABC.MRB(6,6)]); %vesselABC.MRB(1:3,1:3);
Damping = diag([2.6486e5, 8.8164e5, 3.3774e8]);
T_n = 70; %period of interest -- can tune
omega_n_dp = 2* pi / T_n;
zeta = 0.7; %--- can tune
rise_time = 10; %--- can tune

%%PID values
% Kp = diag(Mass .* omega_n_dp^2);
% Ki = (omega_n_dp/10 .*Kp);
% Kd = diag((2 * zeta * omega_n_dp .* Mass) - Damping);
% % Initial
% Kp = 1.0e+07 *([0.0101; 0.0031; 2.1964]); 
% 
% Ki = 1.0e+05 *([0.0046; 0.0026; 1.9715]);
% 
% Kd = 1.0e+08 *([0.0100; 0.0140; 3.4258]);


%Manually tuned
% Kp = 1.0e+07 *([0.0051; 0.0051; 2.1964]); 
% 
% Ki = 1.0e+05 *([0.0046; 0.0046; 1.9715]);
% 
% Kd = 1.0e+08 *([0.0080; 0.0080; 3.4258]);


% %Good XYplot from Tuner
% Kp = -[-44440.8471205421; -174748.115243117; -56099945.0910478];
% Ki = -[-540.64009360768; -3153.2361136748; -1036593.12054623];
% Kd = -[-885551.128894883; -1413618.40984523; -582749740.806195];

Kp = [75459.3345349083; 277551.73586971; 120744473.878042];
Ki = [137.081306245593; 763.274947400198; 335358.448218978];
Kd = [1660451.40544401; 3920391.80535684; 1605063439.04156];

%% FOR running the other initialization files
% run("/Users/aduragbemi/Desktop/MIR/NTNU/MCS1/Project/MCS1_Project/Part2/modeling.mlx")
% run("/Part2/nonPassiveFilter.mlx")
% run("/Part2/test.m")





