function hdl = drawSquare(x,y,scale,theta)
hdl = theta;

R= ([cos(theta), -sin(theta); sin(theta), cos(theta)]);

X=([-scale/2, scale/2, scale/2, -scale/2]);
Y=([-scale/2, -scale/2, scale/2, scale/2]);

for i=1:4
    T(:,i)=R*[X(i); Y(i)];
end

x_lower_left=x+T(1,1);
x_lower_right=x+T(1,2);
x_upper_right=x+T(1,3);
x_upper_left=x+T(1,4);

y_lower_left=y+T(2,1);
y_lower_right=y+T(2,2);
y_upper_right=y+T(2,3);
y_upper_left=y+T(2,4);

x_coor=[x_lower_left x_lower_right x_upper_right x_upper_left];
y_coor=[y_lower_left y_lower_right y_upper_right y_upper_left];

patch('Vertices',[x_coor; y_coor]','Faces',[1 2 3 4],'Edgecolor','g','Facecolor','none','Linewidth',1.2);


end