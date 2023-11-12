function [inv_M, Aw, Tb, Cw, E, B, H, R, Q, dt, inv_Tb, TAU] = get_observer_parameters(M)

K_w = 0.001*diag([1, 1, 1]); %-------TUNE
Ew = [zeros(3); K_w];
Eb = diag([1, 1, 1]); %-----TUNE 
E = [Ew, zeros(6,3);
            zeros(3,3), zeros(3,3);
            zeros(3,3), Eb;
            zeros(3,3),zeros(3,3)];

dt = 0.1;
TAU = dt*E;E = [Ew, zeros(6,3);
            zeros(3,3), zeros(3,3);
            zeros(3,3), Eb;
            zeros(3,3),zeros(3,3)];

% obs.Q = diag([1,1,0.1,1e4,1e4,1e5]);

B =  [zeros(6,3);zeros(3,3);zeros(3,3);inv(M)];

R = diag([0.00001,0.00001,0.01*pi/180])*10e-4; %tune later %measurement

Q = diag([0.1,0.1,pi/180,1e6,1e6,1e9])*10e3; %tune this

% 
% R = diag([1  1e1 0.5e-2]);
% Q = diag([2e-2 1e-2 1e-2 2e7 2e7 1e9]);

Cw = [zeros(3) eye(3)];
H = [Cw, eye(3), zeros(3,3) zeros(3,3)];

T_n = [0.6 0.15 0.2]; %period of interest -- can tune
omega_n = 2* pi ./ T_n;
zetas = 0.01; %--- can tune
% Omega = diag([omega_n, omega_n, omega_n]);
Omega = diag([omega_n]);
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

end
