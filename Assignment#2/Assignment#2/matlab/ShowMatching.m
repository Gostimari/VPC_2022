function ShowMatching(MatchList,img1,img2,Dscpt1,Dscpt2)
% Show all matches by ploting the line that connects both matched keypoints. 
% Create a composed image with the original and query image to plot the connected points.
% Allow also the possibility to visualise the 8x8 (or 5x5) feature patches
% per matching.

for i = 1:size(MatchList,1) %For every element that is a supposed match
    %Gets the correct match
    p=H*[Pts1.y(MatchList(i,1));Pts1.x(MatchList(i,1));1]; 
    xa=floor(p(1)/p(3)); 
    ya=floor(p(2)/p(3));
    
    %Gets the supposed match
    xt=Pts2.y(MatchList(i,2));
    yt=Pts2.x(MatchList(i,2));

end

end
        