clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

maxDisp = 50;
windowSize = 15;
dispM = computeDisparity(im1, im2, maxDisp, windowSize);

% --------------------  get depth map

depthM = computeDepth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);


% --------------------  Display

figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;
