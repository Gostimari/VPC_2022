function [ K, R, C ] = decomposeEXP(P)
%decompose P into K, R and t

%P = [A b]
A = P(:,1:3);
b = P(:,4);

%following the steps
C = -inv(A) * b;

epsilon = 1;
rho = epsilon/norm(A(3,:));

cos_t = dot(cross(A(1,:),A(3,:)),cross(A(2,:),A(3,:))) / dot(norm(cross(A(1,:),A(3,:))),norm(cross(A(2,:),A(3,:))));
sin_t = sqrt(1-cos_t^2);

alpha = rho.^2 * norm(cross(A(1,:),A(3,:))) * sin_t;
beta = rho.^2 * norm(cross(A(2,:),A(3,:))) * sin_t;

r1 = (1/norm(cross(A(2,:),A(3,:))))*cross(A(2,:),A(3,:));
r3 = rho*A(3,:);
r2 = cross(r3,r1);

u0 = rho^2*dot(A(1,:),A(3,:));
v0 = rho^2*dot(A(2,:),A(3,:));

R = [r1; r2; r3];
K = [alpha -alpha*(cos_t/sin_t) u0; 0 beta/sin_t v0; 0 0 1];

end