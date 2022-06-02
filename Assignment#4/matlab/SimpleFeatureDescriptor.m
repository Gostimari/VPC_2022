function [Descriptors] = SimpleFeatureDescriptor(img0,pts,N)

window = zeros(N); % Simple window 5x5 square
Descriptors = zeros(size(pts,1),N*N); %Array with the number of rows of keypoints and columns with dimension of the feature

imgpad = padarray(img0,[floor(N/2) floor(N/2)],'replicate','both'); % Increases image in half the size of N

for n = 1:size(pts,1)
    window = imgpad(floor(pts(n,2)):floor(pts(n,2)+2*floor(N/2)),floor(pts(n,1)):floor(pts(n,1)+2*floor(N/2)));  % 5x5 window centered in the keypoint
    Descriptors(n,:) = reshape(window,1,N*N); % Despriptor line is a vector of size(N*N,1) with the grey levels of wich pixel in the window
end

end
        
        