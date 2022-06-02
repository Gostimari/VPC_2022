function [T,pn] = normalization(pts)

pts = pts';
%data normalization
pts = [pts;ones(1,size(pts,2))];
%centroid
pts_c = [sum(pts(1,:))/size(pts,2) sum(pts(2,:))/size(pts,2)];

%scale
d_num = sum(sqrt((pts(1,:)-pts_c(1)).^2 + (pts(2,:)-pts_c(2)).^2));
d_den = size(pts,2)*sqrt(2);
d = d_num/d_den;

%Normalize points
T = inv([d 0 pts_c(1);0 d pts_c(2);0 0 1]); 
pn = T*pts;
end