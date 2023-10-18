function F = F_x_t(x,t, D, M)
%t is 3x1 vector ---> x,y,psi
%x is a 6x1 vector ---> x,y,psi, u,v,r
%D is the damping matrix 3x3
%M is the Mass matrix

Dr = -inv(M)*D;
psi = x(3,1);
u = x(4,1);
v = x(5,1);
r = x(6,1);

F(1,1) = cos(psi)*u - sin(psi)*v;
F(2,1) = sin(psi)*u + cos(psi)*v;
F(3,1) = r;
F(4:6,1) = Dr*[u;v;r] + inv(M)*t


end
