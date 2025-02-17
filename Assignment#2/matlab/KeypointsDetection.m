function [Pts] = KeypointsDetection(img0,Pts)
    
    %Data stucture pts
    Pts.s = [];
    Pts.o = [];

    %scale
    sigma0 = .25;

    %multi-scale pyramid
    for j = 1:6
        sigma(j) = 2^j * sigma0; %Obtain the different sigmas through the pyramid
        H = -sigma(j)^2*fspecial('log',2*ceil(3*sigma(j))+1,sigma(j)); %obtain the log kernel
        G(:,:,j) = conv2(img0,H,'same'); %Apply the log kernel to the image
        %figure();
        %imshow(G(:,:,j),[]);
    end

    for i = 1:size(Pts.x,1)
        L(i,1:6) = abs(G(Pts.x(i),Pts.y(i),:));
    end

    maximo = max(L');

    for i = 1:size(maximo,2)
        [~,r] = find(L == maximo(i));
        sigma = 2*r*sigma0;
        Pts.s = [Pts.s;sigma]; 
    end

    %Orientation
    Gauss = fspecial('Gauss',13,2);
    Sobel_x = fspecial('sobel');
    Sobel_y = Sobel_x';
    
    img1 = ImageFilter(img0,Gauss);
    
    %computing the gradient with Sobel
    Gx = ImageFilter(img1,Sobel_x);
    Gy = ImageFilter(img1,Sobel_y);
    Gori = rad2deg(atan2(Gy,Gx)); %use angle of the gradient as orientation


    for m = 1:size(Pts.x,1)
        Pts.o = [Pts.o; Gori(Pts.x(m),Pts.y(m))];
    end

%     imshow(img0, []);
%     hold on
%     axis on
% 
%     for n = 1:size(Pts.x,1)
%         drawSquare(Pts.y(n),Pts.x(n),2*sqrt(2)*Pts.s(n),Pts.o(n));
%     end
% 
%     hold off
    
end
            
        