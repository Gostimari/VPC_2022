function [Pts] = HarrisCorner(img0,thresh,sigma_d,sigma_i,NMS_size)
%Your implemention

%Data stucture pts
Pts.x = [];
Pts.y = [];

%hsize = 2*ceil(3*sigma_d)+1; %Calculates the filter size
%hsize1 = 2*ceil(3*sigma_i)+1; %Calculates the filter size
Gauss = fspecial('gaussian',7,sigma_d); %Generates the filter
Gauss1 = fspecial('gaussian',13,sigma_i); %Generates the filter

%img1 = ImageFilter(img0,Gauss); %Smooths the image with gaussian filter

%Sobel filter for the gradients
Sobelx = fspecial('sobel');
Sobely = Sobelx';

%Convolution of the sobel masks
Gaussdx = ImageFilter(Gauss,Sobelx);
Gaussdy = ImageFilter(Gauss,Sobely);

%Gets the derivatives
Gx = ImageFilter(img0,Gaussdx);
Gy = ImageFilter(img0,Gaussdy);

%h1 = sum(imgx.*imgx);
%h2 = sum(h1)

h1 = ImageFilter(Gx.^2,Gauss1);
h2 = ImageFilter(Gy.^2, Gauss1);
h3 = ImageFilter(Gx.*Gy, Gauss1);

%H = [sum(h1) sum(h3); sum(h3) sum(h2)];

%c = det(H)-0.1*(trace(H)).^2;
c = h1.*h2-(h3).^2-0.1.*(h1+h2).^2;
%thresh=0.05*max(c,[],'all');
%thresh = 0.02;
c(c < thresh*max(max(c))) = 0;

[x,~]=find(c); %returns the number of non-zero entries
for i=1:numel(x)
    Cnew = sort(c(:),"descend");
    Chigh=Cnew(1);   

    if Chigh == 0
        break
    end
    
    [xh,yh]=find(c == Chigh,1);

    %Suppression of close lines 
    %Low x limit, if the actual x-N is lower than 1, it means that the 
    %neighbor size doesn't fit the image.
    lowLimitX = max([xh-NMS_size 1]); 
    highLimitX = min([xh+NMS_size size(c,1)]);
    lowLimitY = max([yh-NMS_size 1]);
    highLimitY = min([yh+NMS_size size(c,2)]);
    c(lowLimitX:highLimitX,lowLimitY:highLimitY) = 0;
    
    %Saves the pair of points
    Pts.x = [Pts.x;xh];
    Pts.y = [Pts.y;yh];
end

figure();
imshow(img0,[]);
hold on
scatter(Pts.y,Pts.x,100,'r','+')

end
    
                
        
        
