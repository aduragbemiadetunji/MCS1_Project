clear
clc

% Assuming you have two 5x1 vectors u and u_max
Td = [2; 3; 1; 5; 4];
Td_r = [2; 3; 3; 1; 5; 5; 4; 4];
Td_max = [1; 2; 6; 4; 6];
Td_min = [0; 0; 0; 0; 0]; 

% Azimuth thruster
azimuth = [2; 4; 5];

% Find the indices of elements in u that are greater than their respective elements in u_max
ind_remove = find(Td > Td_max | Td < Td_min);
ind_keep = find(Td < Td_max & Td > Td_min);

% Suppose you have a 3x8 matrix A
B = [1 2 3 4 5 6 7 8;
     6 7 8 9 10 11 12 13;
     11 12 13 14 15 16 17 18];

tau = [10; 10; 10];
alpha = [pi/2; pi/6; pi/2; pi/3; -pi/3];

if length(ind_remove) == length(Td)
    Td(Td > Td_max) = Td_max(Td > Td_max);
    Td(Td < Td_min) = Td_min(Td < Td_min);
elseif length(ind_remove) ~= length(Td) && ~isempty(ind_remove)
    % Use ismember to check if the azimuth outside the constraint
    isInArray = sum(ismember(azimuth, ind_remove));

    % Count how many thruster outside the constraint
    count_remove = length(ind_remove) + isInArray;

    % Create new matrix with new dimension
    new_B = zeros(3, size(B,2)-count_remove);

    % Go over the keeped column
    k = 1;
    for i = ind_keep.'
        if i == 1
            new_B(:,k) = B(:, 1);
            k = k + 1;
        elseif i == 2
            new_B(:,k:(k+1)) = B(:, 2:3);
            k = k + 2;
        elseif i == 3
            new_B(:,k) = B(:, 4);
            k = k + 1;
        elseif i == 4
            new_B(:,k:(k+1)) = B(:, 5:6);
            k = k + 2;
        elseif i == 5
            new_B(:,k:(k+1)) = B(:, 7:8);
            k = k + 2;
        end
    end
    % Compute the new_tau with a reduction from the maximum thruster
    new_tau = tau;
    for i_r = ind_remove.'
        if i_r == 1
            new_tau = new_tau - (B(:,1)*Td_r(1));
        elseif i_r == 2
            new_tau = new_tau - sqrt((B(:,2)*Td_r(2)).^2 +(B(:,3)*Td_r(3)).^2);
        elseif i_r == 3
            new_tau = new_tau - (B(:,3)*Td_r(4));
        elseif i_r == 4
            new_tau = new_tau - sqrt((B(:,5)*Td_r(5)).^2 +(B(:,6)*Td_r(6)).^2);
        elseif i_r == 5
            new_tau = new_tau - sqrt((B(:,7)*Td_r(7)).^2 +(B(:,8)*Td_r(8)).^2);
        end
    end
    
    % Compute new_Td_r
    new_B;
    new_Td_i = pinv(new_B) * new_tau;

    % % Compute new_Td
    new_Td_r = zeros(length(Td_r),1);
    new_alpha = [pi/2; 0; pi/2; 0; 0];
     
    for i = ind_remove.'
        if i == 1
            new_Td_r(1) = Td_r(1);
        elseif i == 2
            new_Td_r(2:3) = Td_r(2:3);
        elseif i == 3
            new_Td(4) = Td_r(4);
        elseif i == 4
            new_Td_r(5:6) = Td_r(5:6);
        elseif i == 5
            new_Td_r(7:8) = Td_r(7:8);
        end
    end

    k = 1;
    for i_r = ind_keep.'
        if i_r == 1
            new_Td_r(1) = new_Td_i(k);
            k = k+1;
        elseif i_r == 2
            new_Td_r(2:3) = new_Td_i(k:(k+1));
            k = k+2;
        elseif i_r == 3
            new_Td_r(4) = new_Td_i(k);
            k = k+1;
        elseif i_r == 4
            new_Td_r(5:6) = new_Td_i(k:(k+1));
            k = k+2;
        elseif i_r == 5
            new_Td_r(7:8) = new_Td_i(k:(k+1));
            k = k+2;
        end
    end
    Td_r = new_Td_r
    Td = [Td_r(1); 
          sqrt(Td_r(2)^2 + Td_r(3)^2); 
          Td_r(4); 
          sqrt(Td_r(5)^2 + Td_r(6)^2);
          sqrt(Td_r(7)^2 + Td_r(8)^2)]

    alpha2 = atan2(Td_r(3),Td_r(2));
    alpha4 = atan2(Td_r(6),Td_r(5));
    alpha5 = atan2(Td_r(8),Td_r(7));

    alpha = [pi/2; alpha2; pi/2; alpha4; alpha5]
end







% 
% 
% 
% % List of column indices to remove
% columns_to_remove = indices;
% 
% % Create a logical index of columns to keep
% columns_to_keep = true(1, size(A, 2))
% columns_to_keep(columns_to_remove) = false
% 
% % Remove the specified columns
% A = A(:, columns_to_keep);
% 
% disp('Matrix after removing specified columns:');
% disp(A);
