function ShowMatching(MatchList,img1,img2,Dscpt1,Dscpt2)
% Show all matches by ploting the line that connects both matched keypoints. 
% Create a composed image with the original and query image to plot the connected points.
% Allow also the possibility to visualise the 8x8 (or 5x5) feature patches
% per matching.
    if(size(img2,1)<size(img1,1))
        img2 = padarray(img2,[20 120],0,'post');
    end        
    img_m = cat(2,img1,img2);
    dim = size(img1,2);

    figure; imshow(img_m);
    Tresh_Match = 5;
    hold on;
    for i=1:size(MatchList,1)
        
        v = [MatchList(i,1:2) 1]';
        v(1) = v(1)/v(3);
        v(2) = v(2)/v(3);
        
        if (MatchList(i,3) <= v(1) + Tresh_Match  && MatchList(i,3) >= v(1) - Tresh_Match ) && (MatchList(i,4)<= v(2) + Tresh_Match && MatchList(i,4) >= v(2) - Tresh_Match) 
            scatter(MatchList(i,1), MatchList(i,2),'r','s')
            scatter(dim+MatchList(i,3), MatchList(i,4),'r','o')
            plot([MatchList(i,1) MatchList(i,3)+dim],[MatchList(i,2) MatchList(i,4)],'g');
        end
    end
    hold off
end
        