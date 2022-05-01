function [img1] = ImageFilter(img0, k)

%verificar se o kernel é separáv
[U,D,V] =svd(k);

%Separar o kernel
v = sqrt(D(1,1))*U(:,1);
h = sqrt(D(1,1))*V(:,1)';

%Aumentar a imagem
imgpad = padarray(img0,[floor(size(k,1)/2) floor(size(k,2)/2)],'replicate','both');

%Convolução vertical
vpad = repmat(v,1,size(imgpad,2));

imgcv = zeros(size(img0,1),size(imgpad,2)); 
for m=1:1:size(img0,1)
    cv = vpad.*imgpad(m:m+size(vpad,1)-1,:);
    imgcv(m,:) = sum(cv);
end

%Convolução horizontal
hpad = repmat(h,size(imgcv,1),1);

imgch = zeros(size(img0,1),size(img0,2));
for n=1:1:size(img0,2)
    ch = hpad.*imgcv(:,n:n+size(hpad,2)-1);
    imgch(:,n) = sum(ch,2);
end

img1 = imgch;
end
