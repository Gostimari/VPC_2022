function dispM = computeDisparity(im1, im2, maxDisp, windowSize)
% computeDisparity creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

% find the points of the image 1 without the black points
[y,x] = find(im1);
pts1 = [x y];

%Get the descriptors for all the points in img1
[DesciptorsImg1]=SimpleFeatureDescriptor(im1,pts1,windowSize);

dispM = zeros(size(im1,1),size(im1,2));
for i=1:size(pts1,1)
        p2 = [];
        Match = [];
        %disparity limits for the coordnates of the points on the 2 image
        % the x can vary from -maxDisp to +maxdisp
        %and the y is the same as image 1

        lowLimitX = max([pts1(i,1)-maxDisp 1]);
        highLimitX = min([pts1(i,1)+maxDisp size(im1,2)]);
        p2(:,1) = lowLimitX:highLimitX;
        p2(:,2) = y(i);

        %Obtain the discriptor for every point inside the limits
        [DesciptorsImg2]=SimpleFeatureDescriptor(im2,p2,windowSize);
        %Calculate the match descriptor to find the image correspondent point on
        %image 2
        [Match]=SSDFeatureMatching(DesciptorsImg1(i,:),DesciptorsImg2);
        
         % the minimal value of the match is the wanted match
         %Calculate the dispMap formula
        aux = min(Match(:));
         d = pts1(i,1) - p2(aux,1);
         dispM(y(i),x(i)) = abs(d);
end

end
