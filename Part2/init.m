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
L = 1000;
kappa2 = 0.0026;
gust_limit = 40;
