function A_mat = A(x,M,D)
Dr = -inv(M)*D

psi = x(3,1)
u = x(4,1)
v = x(5,1)
r = x(6,1)

A_mat = zeros(6,6)

A_mat(1,3) = -u*sin(psi)-v*cos(psi)
A_mat(1,4) = cos(psi)
A_mat(1,5) = -sin(psi)

A_mat(2,3) = u*cos(psi)-v*sin(psi)
A_mat(2,4) = sin(psi)
A_mat(2,5) = cos(psi)

A_mat(3,6) = 1

A_mat(4:6,4:6) = Dr


end