function f = fminGoldRadial(p, xy, XYZ, w)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];
kd = [p(13) p(14)]; % radial distortion coeficients

[K, R, C] = decomposeEXP(P);

%Gets the position after distortion
xyd=inv(K)*xy;

Aux = [R -R*C(1:3)];
%compute squared geometric error with radial distortion
for i = 1:size(XYZ,2)
    %calculate the ideal linear projection of a 3D point P
    xy2(i,:)=Aux*[XYZ(:,i)];
    %change it to 2D - eq 19
    x(i) = xy2(i,1)/xy2(i,3); 
    y(i) = xy2(i,2)/xy2(i,3); 

    %radius of the distortion
    r(i) = sqrt((x(i))^2 + (y(i))^2);
    
    %calculate the distortion factor
    L(i) = 1 + kd(1)*r(i)^2 + kd(2)*r(i)^4;

    %Actual position after radial distortion
     xd(i) = x(i)*L(i);
     yd(i) = y(i)*L(i);
end

for i =1:size(XYZ,2)
    d=sqrt((xyd(1,i)-xd(i)).^2+((xyd(2,i)-yd(i)).^2));
end

soma = sum(d);
%compute cost function value
f = soma;
end
