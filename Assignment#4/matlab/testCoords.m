% A test script using coords.mat
%
clear; clc;

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load('../data/correspondences.mat','M','pts1','pts2');
load('../data/intrinsics.mat','K1','K2');
load('../data/coords.mat');

[F,Fd] = computeF(pts1, pts2); %Compute Fundamental Matrix

coords2  = findEpipolarMatches(im1, im2, Fd, coords1); %Epipolar Match
% subplot 121
% hold on
% imshow(im1);
% scatter(coords1(:,1),coords1(:,2),40,'.','r');
% subplot 122
% hold on
% imshow(im2);
% scatter(coords2(:,1),coords2(:,2),40,'.','b');

E = computeE(Fd, K1, K2); %Compute Essencial Matrix

%Compute 3D sparce structure
P1 = K1*[eye(3) zeros(3,1)];
P2 = camera2(E);

for i=1:size(P2,3)
    pts3d(:,:,i) = triangulation1(P1,coords1,P2(:,:,i),coords2);
    figure();
    plot3(pts3d(:,1,i),pts3d(:,2,i),pts3d(:,3,i),'.');
end

%Compute Extrinsic Parameters
[U,D,V] = svd(E);

W = [0 -1 0;1 0 0;0 0 1];
R1 = U*W'*V'; % Rotation matrices
R2 = U*W*V';
t1 = -U(:,end);
t2 = U(:,end);


% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
