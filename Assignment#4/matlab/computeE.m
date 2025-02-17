function E = computeE(F, K1, K2)
% computeE computes the essential matrix
%   Args:
%       F:  Fundamental Matrix
%       K1: Camera Matrix 1
%       K2: Camera Matrix 2
%
%   Returns:
%       E:  Essential Matrix
%

E = K1 * F * K2'; % Essencial matrix is related with fundamental matrix with this formula

end