function depthM = computeDepth(dispM, K1, K2, R1, R2, t1, t2, bits)
% computeDepth creates a depth map from a disparity map (DISPM).

% optical centres of the cameras
c1 =-inv(K1*R1)*K1*t1;
c2 =-inv(K2*R2)*K2*t2;

b=norm(c1-c2); 
f=K1(1,1);

depthM(:,:)=(b*f)./dispM; % formula for depth

for i = 1:size(dispM,1)
    for j= 1:size(dispM,2)
        if dispM(i,j) == 0
            depthM(i,j)=0;
        end
    end
end
end