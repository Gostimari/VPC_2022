function ShowMatching(MatchList,img1,img2,Dscpt1,Dscpt2)
% Show all matches by ploting the line that connects both matched keypoints. 
% Create a composed image with the original and query image to plot the connected points.
% Allow also the possibility to visualise the 8x8 (or 5x5) feature patches
% per matching.

figure()
imshow(img1,[]);
hold on
for i = 1:size(MatchList,1) %For every element that is a supposed match
    for j = 1:size(MatchList, 2)
        plot(MatchList(i,j), '--ro');
    end

end
hold off
end
        