function [xyn, XYZn, T, U] = normalization(xy, XYZ)

%data normalization
xy=[xy;ones(1,size(xy,2))];
XYZ=[XYZ;ones(1,size(XYZ,2))];

%first compute centroid
xy_c = [sum(xy(1,:))/size(xy,2) sum(xy(2,:))/size(xy,2)];
XYZ_c = [sum(XYZ(1,:))/size(XYZ,2) sum(XYZ(2,:))/size(XYZ,2) sum(XYZ(3,:))/size(XYZ,2)];

%then, compute scale
den_xy=(1/size(xy,2))*sum(sqrt((xy(1,:)-xy_c(1)).^2+(xy(2,:)-xy_c(2)).^2));
xy_s=sqrt(2)/den_xy;
den_XYZ=(1/size(XYZ,2))*sum(sqrt((XYZ(1,:)-XYZ_c(1)).^2+(XYZ(2,:)-XYZ_c(2)).^2+(XYZ(3,:)-XYZ_c(3)).^2));
XYZ_s=sqrt(3)/den_XYZ;

%create T and U transformation matrices
T = [xy_s 0 -xy_s*xy_c(1);0 xy_s -xy_s*xy_c(2);0 0 1];
U = [XYZ_s 0 0 -XYZ_s*XYZ_c(1);0 XYZ_s 0 -XYZ_s*XYZ_c(2);0 0 XYZ_s -XYZ_s*XYZ_c(3);0 0 0 1];

%and normalize the points according to the transformations
xyn = T*xy;
XYZn = U*XYZ;

end