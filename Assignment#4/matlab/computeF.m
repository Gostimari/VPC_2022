function [Fd] = computeF(pts1, pts2)
% computeF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates

% Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

% the function of the previous labs with some modifications
[Tl,pnl] = normalization(pts1);
[Tr,pnr] = normalization(pts2);

A = [];
%Construct a matrix with 8 pares of correspondence points in the two images
for i=1:size(pnl,2)
    linha = [pnl(1,i)*pnr(1,i) pnl(2,i)*pnr(1,i) pnr(1,i) pnl(1,i)*pnr(2,i) pnl(2,i)*pnr(2,i) pnr(2,i) pnl(1,i) pnl(2,i) 1];
    A = [A;linha];
end

[U,D,V] = svd(A);

Fr = reshape(V(:,9),[3 3])'; % F is a 3x3 matrix with the 9 columm of matrix V (smallest singular value)

[U1,D1,V1] = svd(Fr);
D1(3,3) = 0;  % Replace the smallest singular value of D with 0
F1 = U1*D1*V1'; % Fudamental Matrix

%Refine
F1 = refineF(F1,pnl,pnr);

Fd = Tr'*F1*Tl; %  normalized eight point algorithm to obtain F
% Tr e Tl transform matrices obtained on the points normalization 



end
