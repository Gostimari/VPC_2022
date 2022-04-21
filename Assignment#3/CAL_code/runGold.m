function [K, R, C, error] = runGold(xy, XYZ, Dec_type)

%normalize data points
[xy_normalized, XYZ_normalized, T, U] = normalization(xy, XYZ);

%compute DLT
[Pn] = dlt(xy_normalized, XYZ_normalized);

%minimize geometric error
pn = [Pn(1,:) Pn(2,:) Pn(3,:)];
for i=1:20
    [pn] = fminsearch(@fminGold, pn, [], xy_normalized, XYZ_normalized);
end

%denormalize camera matrix
Pn = [pn(1:4);pn(5:8);pn(9:12)];
P = pinv(T)*Pn*U;

%factorize camera matrix in to K, R and t
if Dec_type == "QR"
    [ K, R, C ] = decomposeQR(P);
elseif Dec_type == "EXP"
    [ K, R, C ] = decomposeEXP(P);
end

%compute reprojection error
for i = 1:size(XYZ,2)
    xy2(i,:)=P*[XYZ(:,i);1];
end

%change 3D point location to 2D
for j =1:size(xy2,1)
    xy2(j,1)=xy2(j,1)/xy2(j,3);
    xy2(j,2)=xy2(j,2)/xy2(j,3);
end

%draw figurefin
figure(1)
hold on
scatter(xy(1,:),xy(2,:),100,'b','o');
scatter(xy2(:,1),xy2(:,2),100,'r','o');

error=0;
for x =1:size(XYZ,2)
    d=sqrt((xy(1,x)-xy2(x,1))^2+((xy(2,x)-xy2(x,2))^2));
    error=error+d;
end
error=error/size(xy,2);


end