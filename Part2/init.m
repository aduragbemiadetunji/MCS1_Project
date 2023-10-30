%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% init()                                                                  %
%                                                                         %              
% Set initial parameters for part1.slx and part2.slx                      %
%                                                                         %
% Created:      2018.07.12	Jon Bj�rn�                                    %
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


%% Wind constants/parameters

direction_limit = pi/36;
slow_varying_limit = 1;
mean_wind_direction = 0;
direction_time_constant = 10;
np_direction = 0.1;
np_slow_varying = 5;
u10 = 12;
height = 3;
kappa = 0.003;
N = 500;
slow_varying_time_constant = 100;
phases_min = -pi*ones(N,1);
phases_max = pi*ones(N,1);

L = 180;
kappa2 = 0.0026;
