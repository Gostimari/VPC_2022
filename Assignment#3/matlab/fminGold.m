function f = fminGold(p, xy, XYZ, w)

%reassemble P to ignore the radial distortion coeficients
P = [p(1:4);p(5:8);p(9:12)];

%compute squared geometric error
for i = 1:size(XYZ,2)
    xy2(i,:)=P*[XYZ(:,i)];
end

%change coordinates 3D to 2D
for j =1:size(xy2,1)
    xy2(j,1)=xy2(j,1)/xy2(j,3);
    xy2(j,2)=xy2(j,2)/xy2(j,3);
end

for x =1:size(XYZ,2)
    d=sqrt((xy(1,x)-xy2(x,1)).^2+((xy(2,x)-xy2(x,2)).^2));
end

soma = sum(d);
%compute cost function value
f = soma;
end