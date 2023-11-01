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

% edit
Mass =    [7.0101e+06  0            0;
            0    8.519e+06   4.7187e+05;
            0  4.7187e+05   3.7973e+09];
Damping = diag([2.6486e5, 8.8164e5, 3.3774e8]);


%% %% data for reference model
%ti is 1/ti from slide 10
ti = [1/50, 1/50, 1/100]; %good
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

M = Mass;
D = Damping;
T_n = 70; %period of interest -- can tune
omega_n_dp = 2* pi / T_n;
zeta = 0.7; %--- can tune
rise_time = 10; %--- can tune

%%PID values

Kp = [75459.3345349083; 277551.73586971; 120744473.878042];
Ki = [137.081306245593; 763.274947400198; 335358.448218978];
Kd = [1660451.40544401; 3920391.80535684; 1605063439.04156];


%observer

[inv_M, Aw, Tb, Cw, E, B, H, R, Q, dt, inv_Tb, TAU] = get_observer_parameters(M);
% plot(simout.Data(:,1),simout.Data(:,2))


