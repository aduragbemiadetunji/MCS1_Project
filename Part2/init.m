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
ti = [1/5, 1/5, 1/10]; %good
Af = diag(ti);

omega_is = [0.2, 0.2, 0.2]; %0.1 ish
% omega_is = [2, 3, 4];
zeta_is = [1.5, 1.5, 1.5]; %1.2 ish
% zeta_is = [2, 4, 5];

Gamma = diag(omega_is);
Omega = diag(2*omega_is.*zeta_is);

%number of simulation
simulation = 1;
change_position_time = 400;
%% PID Parameters
Mass = diag([vesselABC.MRB(1,1), vesselABC.MRB(2,2), vesselABC.MRB(6,6)]); %vesselABC.MRB(1:3,1:3);
Damping = diag([2.6486e5, 8.8164e5, 3.3774e8]);

M = Mass;
D = Damping;
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


%observer

K_w = diag([1, 1, 1]); %-------TUNE
Ew = [zeros(3); K_w];
Eb = diag([1, 1, 1]); %-----TUNE 
E = [Ew, zeros(6,3);
            zeros(3,3), zeros(3,3);
            zeros(3,3), Eb;
            zeros(3,3),zeros(3,3)];

dt = 0.01;
TAU = dt*E;E = [Ew, zeros(6,3);
            zeros(3,3), zeros(3,3);
            zeros(3,3), Eb;
            zeros(3,3),zeros(3,3)];

obs.Q = diag([1,1,0.1,1e4,1e4,1e5]);

B =  [zeros(6,3);zeros(3,3);zeros(3,3);inv(M)];
R = diag([1,1,0.1]); %tune later
Q = diag([1,1,0.1,1e2,1e2,1e2])*10e26; %tune this


Cw = [zeros(3) eye(3)];
H = [Cw, eye(3), zeros(3,3) zeros(3,3)];

T_n = 20; %period of interest -- can tune
omega_n = 2* pi / T_n;
zetas = 0.1; %--- can tune
Omega = diag([omega_n, omega_n, omega_n]);
Caret = diag([zetas, zetas, zetas]);
Tb = 0.1 * eye(3); %tune the 0.1
inv_Tb = inv(Tb);
Aw =  [zeros(3) eye(3);
    -Omega^2 -2*Caret*Omega];

K_w = diag([1, 1, 1]); %-------TUNE
Ew = [zeros(3); K_w];

Eb = diag([1, 1, 1]); %-----TUNE
E = [Ew, zeros(6,3);
            zeros(3,3), zeros(3,3);
            zeros(3,3), Eb;
            zeros(3,3),zeros(3,3)];


inv_M = inv(M);
dt = 0.1;
TAU = dt*E;
% plot(simout.Data(:,1),simout.Data(:,2))


