function [img1] = EdgeFilter(img0, sigma)
%Your implemention

%Thresholds used to detect strong edges and weak edges
highThreshold = 0.08;
lowThreshold = 0.05;

hsize = 2*ceil(3*sigma)+1; %Calculates the filter size
Gauss = fspecial('gaussian',hsize,sigma); %Generates the filter ( blur na imagem e diminui o ruido)

img1 = ImageFilter(img0,Gauss); %Smooths the image with gaussian filter

%Sobel filter for the gradients (imagem que salienta os cantos)
Sobelx = (fspecial('sobel'))';
Sobely = fspecial('sobel');

%Convolution of the sobel masks\
imgx = ImageFilter(img1,Sobelx);
imgy = ImageFilter(img1,Sobely);

%Calculates the gradient magnitude and the gradient direction
Gmag = abs(sqrt(imgx.^2+imgy.^2));
img1=Gmag; %Copies the image gradient magnitude to a new image
Gdir = rad2deg(atan(imgy./imgx));

for i=2:1:size(Gdir,1)-1
    for j=2:1:size(Gdir,2)-1 
        if (Gdir(i,j) <= 22.5 && Gdir(i,j)>= -22.5) || (Gdir(i,j) <= -157.5 && Gdir(i,j) >= 157.5)
            dir = 0; %Horizontal
        elseif (Gdir(i,j) <= 67.5 && Gdir(i,j)>= 22.5) || (Gdir(i,j) <= -112.5 && Gdir(i,j) >= -157.5)
            dir = 1; %Diagonal direita
        elseif (Gdir(i,j) <= 112.5 && Gdir(i,j)>= 67.5) || (Gdir(i,j) <= -67.5 && Gdir(i,j) >= -112.5)
            dir = 2; %Vertical
        elseif (Gdir(i,j) <= 157.5 && Gdir(i,j)>= 112.5) || (Gdir(i,j) <= -22.5 && Gdir(i,j) >= -67.5)
            dir = 3; %Diagonal esquerda
        end

        switch dir
            case 0 %Horizontal
                if Gmag(i,j)<Gmag(i,j+1) || Gmag(i,j)<Gmag(i,j-1)
                    img1(i,j)=0;
                end
            case 1 %Diagonal direita
                if Gmag(i,j)<Gmag(i-1,j-1) || Gmag(i,j)<Gmag(i+1,j+1)
                    img1(i,j)=0;
                end
            case 2 %Vertical
                if Gmag(i,j)<Gmag(i-1,j) || Gmag(i,j)<Gmag(i+1,j)
                    img1(i,j)=0;
                end
            case 3 %Diagonal esquerda
                if Gmag(i,j)<Gmag(i-1,j+1) || Gmag(i,j)<Gmag(i+1,j-1)
                    img1(i,j)=0;
                end
        end   
    end
    j=2;
end

img1(img1<lowThreshold) = 0; %Eliminates very weak edges due to noise or color variations