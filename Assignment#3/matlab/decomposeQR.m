function [ K, R, C ] = decomposeQR(P)
%decompose P into K, R and t

%sdv of P to obtain the right null-vector
[U, S, V] = svd(P);
C = V(:,end);

% QR-decomposition on the inverse of the left 3x3 of P
[Q, R] = qr(inv(P(1:3,1:3)));

K = inv(R);
R = inv(Q);

end