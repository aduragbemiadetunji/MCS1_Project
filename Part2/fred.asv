
function [u, alpha] = fred(tau, B)

Td0 = zeros(8,1);
 
persistent u_l

if isempty(u_l)
    u_l = Td0;
end

u_max = 10.*[125000, 125000, ones(1,2)*150000, ones(1,2)*320000, ones(1,2)*320000]';
u_min = -u_max;

h = 0.1;

delta_max = 10.*[ones(1,2)*125000/8*h, ones(1,2)*150000/8*h, ones(1,2)*320000/10*h,ones(1,2)*320000/10*h]';
delta_min = -delta_max;

lim_max = delta_max + u_l;
lim_min = delta_min + u_l;

sWeight = 1e4;

H =  2*diag([1,1,1,1,0.8,0.8,0.8,0.8,sWeight,sWeight,sWeight*10]);
 
A_eq = [B, -eye(3)];

A = [-eye(8) ,  zeros(8,3);
      eye(8) ,   zeros(8,3)];

b_eq = tau;
b = [-(max(u_min, lim_min));
    min(u_max,lim_max)];

f = zeros(length(H),1);
x = ones(11,1);

coder.extrinsic('quadprog');
coder.extrinsic('optimoptions');
options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off','Steptolerance',1e-30,'OptimalityTolerance',1e+3);

x = quadprog(H,f,A,b,A_eq,b_eq, [],[],[],options);
Td = x(1:8);

uy_aft = Td(5)+Td(7);
u04 = -0.0001*320*10^3;
u05 = 0.0001*320*10^3; 

if uy_aft >= 0
    u4y = u04;
    u5y = uy_aft+u05;
else
    u4y = uy_aft+u04;
    u5y = u05;
end
u4x = Td(6);
u5x = Td(8);

%{
u1 = Td(1);
u2 = Td(2);
u3 = sqrt(Td(3)^2 + Td(4)^2);
u4 = sqrt(Td(5)^2 + Td(6)^2);
u5 = sqrt(Td(7)^2 + Td(8)^2);
 
a1 = pi/2;
a2 = pi/2;
a3 = atan2(Td(3), Td(4));
a4 = atan2(Td(5), Td(6));
a5 = atan2(Td(7), Td(8));
%}

u1 = Td(1);
u2 = Td(2);
u3 = sqrt(Td(3)^2+Td(4)^2);
u4 = sqrt(u4x^2+u4y^2);
u5 = sqrt(u5x^2+u5y^2);

a1 = pi/2;
a2 = pi/2;
a3 = atan2(Td(3),Td(4));
a4 = atan2(u4y,u4x);
a5 = atan2(u5y,u5x);

u_l = Td(1:8);

alpha = [a1 a2 a3 a4 a5]';
u = [u1 u2 u3 u4 u5]';