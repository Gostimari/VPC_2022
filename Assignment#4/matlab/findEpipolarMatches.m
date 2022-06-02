function [pts2] = findEpipolarMatches(im1, im2, F, pts1)
% findEpipolarMatches:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

for i=1:size(pts1,1)
    l(i,:)=F*[pts1(i,:) 1]'; %Gets all the lines from the fundamental matrix l = F * x  F = e*H_phi
    
    s = sqrt(l(i,1)^2+l(i,2)^2);
    l(i,:)=l(i,:)/s; %Normalize the line parameters
end

%Convert the image to grayscale to find the descriptors
im1=double(rgb2gray(im1));

% the function of the previous labs with some modifications
%Get the descriptors for all the points in img1
[DesciptorsImg1]=SimpleFeatureDescriptor(im1,pts1,15);
pts2=[];

for n=1:size(l,1)  
    %Gets the points from 2 image
    for x=1:size(im1,2)
        p2(x,2) = -(l(n,1) * x + l(n,3))/l(n,2); % line equation being L the parameters (a,b,c) to find the y of the points
        p2(x,1)=x;
    end
    
    [DesciptorsImg2]=SimpleFeatureDescriptor(im2,p2,15); %Gets all the descriptors for the points in the line
    [Match]=RatioFeatureMatcher(DesciptorsImg1(n,:),DesciptorsImg2); %Matches the two descriptors
    % Match will be the x coordnate of the point and the floor is to round
    % that value to find the y
    pts2=[pts2;Match(2) floor(p2(Match(2),2))]; 
end
end