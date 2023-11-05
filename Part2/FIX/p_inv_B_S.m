function [Td, alpha] = p_inv_B_S(tau_d)
%% Build the B matrix
% Thruster 1
x1 = 39.3;
y1 = 0;
% Thruster 2
x2 = 35.6;
y2 = 0;
% Thruster 3
x3 = 31.3;
y3 = 0;
% Thruster 4
x4 = -28.5;
y4 = 5;
% Thruster 5
x5 = -28.5;
y5 = -5;

% Redistributed force for each thruster
thr1 = [0 1 x1].';
thr2_x = [1 0 y2].';
thr2_y = [0 1 x2].';
thr3 = [0 1 x3].';
thr4_x = [1 0 y4].';
thr4_y = [0 1 x4].';
thr5_x = [1 0 y5].';
thr5_y = [0 1 x5].';

% B redistributed
B = [thr1 thr2_x thr2_y thr3 thr4_x thr4_y thr5_x thr5_y];

%% Result
tau = [tau_d(1); tau_d(2); tau_d(6)];

Td_r = pinv(B) * tau;

% Thruster control
Td = [Td_r(1); 
      sqrt(Td_r(2)^2 + Td_r(3)^2); 
      Td_r(4); 
      sqrt(Td_r(5)^2 + Td_r(6)^2);
      sqrt(Td_r(7)^2 + Td_r(8)^2)];

alpha2 = atan2(Td_r(3),Td_r(2));
alpha4 = atan2(Td_r(6),Td_r(5));
alpha5 = atan2(Td_r(8),Td_r(7));

alpha = [pi/2; alpha2; pi/2; alpha4; alpha5];

%% Saturation limit constraint
% Azimuth thruster
Td_max = [125; 150; 125; 300; 300];
Td_min = [-125; 0; -125; 0; 0]; 

azimuth = [2; 4; 5];

% Find the indices of elements in u that are greater than their respective 
% elements in u_max
ind_remove = find(Td > Td_max | Td < Td_min);
ind_keep = find(Td < Td_max & Td > Td_min);

% Apply new constraint, don't change if thruster control didn't go above
% the constraints
if length(ind_remove) == length(Td)
    Td(Td > Td_max) = Td_max(Td > Td_max);
    Td(Td < Td_min) = Td_min(Td < Td_min);
elseif length(ind_remove) ~= length(Td_min) && ~isempty(ind_remove)
    % Use ismember to check if the azimuth outside the constraint
    isInArray = sum(ismember(azimuth, ind_remove));

    % Count how many thruster outside the constraint
    count_remove = length(ind_remove) + isInArray;

    % Create new_B and with new dimension
    new_B = zeros(3, size(B,2)-count_remove);

    % Go over the keeped column
    k = 1;
    for i = 1:length(ind_keep)
        % Computing the new_B
        if ind_keep(i) == 1
            new_B(:,k) = B(:, 1);
            k = k + 1;
        elseif ind_keep(i) == 2
            new_B(:,k:(k+1)) = B(:, 2:3);
            k = k + 2;
        elseif ind_keep(i) == 3
            new_B(:,k) = B(:, 4);
            k = k + 1;
        elseif ind_keep(i) == 4
            new_B(:,k:(k+1)) = B(:, 5:6);
            k = k + 2;
        elseif ind_keep(i) == 5
            new_B(:,k:(k+1)) = B(:, 7:8);
            k = k + 2;
        end 
    end

    % Compute the new_tau with a reduction from the maximum thruster
    new_tau = tau;
    for i = 1:length(ind_remove)
        if ind_remove(i) == 1
            new_tau = new_tau - (B(:,1)*Td_r(1));
        elseif ind_remove(i) == 2
            new_tau = new_tau - sqrt((B(:,2)*Td_r(2)).^2 +(B(:,3)*Td_r(3)).^2);
        elseif ind_remove(i) == 3
            new_tau = new_tau - (B(:,3)*Td_r(4));
        elseif ind_remove(i) == 4
            new_tau = new_tau - sqrt((B(:,5)*Td_r(5)).^2 +(B(:,6)*Td_r(6)).^2);
        elseif ind_remove(i) == 5
            new_tau = new_tau - sqrt((B(:,7)*Td_r(7)).^2 +(B(:,8)*Td_r(8)).^2);
        end
    end
    
    % Compute new_Td_r
    new_Td_i = pinv(new_B) * new_tau;

    % % Compute new_Td
    new_Td_r = zeros(length(Td_r),1);
     
    for i = 1:length(ind_remove)
        if ind_remove(i) == 1
            new_Td_r(1) = Td_r(1);
        elseif ind_remove(i) == 2
            new_Td_r(2:3) = Td_r(2:3);
        elseif ind_remove(i) == 3
            new_Td_r(4) = Td_r(4);
        elseif ind_remove(i) == 4
            new_Td_r(5:6) = Td_r(5:6);
        elseif ind_remove(i) == 5
            new_Td_r(7:8) = Td_r(7:8);
        end
    end

    k = 1;
    for i = 1:length(ind_keep)
        if ind_keep(i) == 1
            new_Td_r(1) = new_Td_i(k);
            k = k+1;
        elseif ind_keep(i) == 2
            new_Td_r(2:3) = new_Td_i(k:(k+1));
            k = k+2;
        elseif ind_keep(i) == 3
            new_Td_r(4) = new_Td_i(k);
            k = k+1;
        elseif ind_keep(i) == 4
            new_Td_r(5:6) = new_Td_i(k:(k+1));
            k = k+2;
        elseif ind_keep(i) == 5
            new_Td_r(7:8) = new_Td_i(k:(k+1));
            k = k+2;
        end
    end
    Td_r = new_Td_r;
    Td = [Td_r(1); 
          sqrt(Td_r(2)^2 + Td_r(3)^2); 
          Td_r(4); 
          sqrt(Td_r(5)^2 + Td_r(6)^2);
          sqrt(Td_r(7)^2 + Td_r(8)^2)];

    alpha2 = atan2(Td_r(3),Td_r(2));
    alpha4 = atan2(Td_r(6),Td_r(5));
    alpha5 = atan2(Td_r(8),Td_r(7));

    alpha = [pi/2; alpha2; pi/2; alpha4; alpha5];
end