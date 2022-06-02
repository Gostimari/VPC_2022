function [P] = dlt(xy, XYZ)
%computes DLT, xy and XYZ should be normalized before calling this function

A = [];

%Gets the equations matrix 2n*12 (matrix A)
for i=1:size(xy,2)
    A = [A; XYZ(:,i)' zeros(1,4) -xy(1,i).*(XYZ(:,i))';
         zeros(1,4) XYZ(:,i)' -xy(2,i).*(XYZ(:,i))'];
end

%SVD decomposition
[U, S, V] = svd(A);

%The solution is the last column of V
P = V(:,end);

P = reshape(P, 4, 3)';

end