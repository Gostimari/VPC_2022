function [Descriptors] = FeatureDescriptor(Img,Pts,Dscpt_type,Patch_size)
    
    if (Dscpt_type == 'SIMPLE')

        for i = 1:size(Pts.x, 1)
            N = 5; % Size of the simple patch
            window = zeros(N); % Simple window 5x5 square
            Descriptors = zeros(size(Pts.x,1),N*N); %Array with the number of rows of keypoints and columns with dimension of the feature

            imgpad = padarray(Img,[floor(N/2) floor(N/2)],'replicate','both'); % Increases image in half the size of N        
            window = imgpad(Pts.x(i)+floor(N/2)-2:Pts.x(i)+floor(N/2)+2,Pts.y(i)+floor(N/2)-2:Pts.y(i)+floor(N/2)+2); % 5x5 window centered in the keypoint
            Descriptors(i,:) = reshape(window,1,N*N); % Despriptor line is a vector of size(N*N,1) with the grey levels of wich pixel in the window
        end

    else

        for i = 1:size(Pts.x,1)
            N = Patch_size;
            window = zeros(N); % Simple window 5x5 square
            Descriptors = zeros(size(Pts.x,1),8*8); %Array with the number of rows of keypoints and columns with dimension of the feature
            
            imgpad = padarray(Img,[floor(N/2) floor(N/2)],'replicate','both'); % Increases image in half the size of N 
            window = imgpad(Pts.x(i)+floor(N/2)-20:Pts.x(i)+floor(N/2)+20,Pts.y(i)+floor(N/2)-20:Pts.y(i)+floor(N/2)+20); % 5x5 window centered in the keypoint

            angle = Pts.o(i);
            TR= [cosd(angle) -sind(angle) 0; sind(angle) cosd(angle) 0;0 0 1];
            Tform = affine2d(TR);

            A = imwarp(window, Tform);
            resized = imresize(A,[8 8]);
            Descriptors(i,:) = reshape(resized,1,8*8);
            Descriptors(i,:) = normalize(Descriptors(i,:));
        end

    end

end
        
        