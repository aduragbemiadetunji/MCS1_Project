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
observer_type = 1; % 1 - NonLinear Passive, 0 - EKF
change_position_time = 800;
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
%% PASSIVE NON LINEAR OBSERVERS CONSTANTS AND TUNING VALUES
syms psi
Param.T_n = 2*[10 10 10]; %period of interest -- can tune reduce
Param.omega_n = 2* pi ./ Param.T_n;
Param.zeta = [0.05 0.05 0.05]; %--- can tune reduceee 0.05
Param.Omega = diag([Param.omega_n]);
Param.Caret = diag([Param.zeta]);
Param.Tb = 1 * eye(3); %tune the 0.1
WaveModel.A_w =  [zeros(3) eye(3);
    -Param.Omega^2 -2*Param.Caret*Param.Omega];
WaveModel.C_w = [zeros(3) eye(3)];

ModelParams.Mass =    [7.0101e+06  0            0;
            0    8.519e+06   4.7187e+05;
            0  4.7187e+05   3.7973e+09];
ModelParams.Damping = diag([2.6486e5, 8.8164e5, 3.3774e8]);

ModelParams.rot = [cos(psi) -sin(psi) 0;
    sin(psi) cos(psi) 0;
    0 0 1];

npf.zeta_ni = [1.0 1.0 1.0]; %----can tune
npf.zeta_i = [0.1 0.1 0.1]; %-----can tune
npf.omega_i = Param.omega_n;
npf.omega_ci = 1.3*npf.omega_i; %----can tune the 5 to make wci >>> wi

npf.k1_3 =  -2 * (npf.zeta_ni - npf.zeta_i) .* (npf.omega_ci./npf.omega_i);
npf.k4_6 = 2 * npf.omega_i .* (npf.zeta_ni-npf.zeta_i);
npf.k7_9 = npf.omega_ci;
% npf.k13_15 = [6.5e06 6.5e06 2.5e09]; %-----can tune
npf.k13_15 = 1000*[45 40 100];
npf.k10_12 = 0.08*npf.k13_15; %-----can tune

npf.K_1 = [diag([npf.k1_3]); diag([npf.k4_6])];
npf.K_2 = diag([npf.k7_9]);
npf.K_3 = diag([npf.k10_12]); %0.01-0.1 k4
npf.K_4 = diag([npf.k13_15]); %propo to mass
%% EKF CONSTANTS AND TUNING PARAMETERS
M = Mass;
D = Damping;
[inv_M, Aw, Tb, Cw, E, B, H, R, Q, dt, inv_Tb, TAU] = get_observer_parameters(M);
%% WIND VALLUES AND CONSTANTS
%Simulation time
N = 500;

%% Wind constants/parameters
%Set to 1 to turn on wind effect
wind = 1;

%Wind direction
direction_limit = pi/36;
mean_wind_direction = pi/2;
np_direction = 0.1;
direction_time_constant = 100;

%Slow varying wind
slow_varying_limit = 1;
np_slow_varying = 5;
slow_varying_time_constant = 100;

%Wind gust and mean wind component
u10 = 12;
height = 3;
kappa = 0.003;
L = 1800;
kappa2 = 0.0026;
gust_limit = 40;
%% Thrust Allocation Constants/Parameters

