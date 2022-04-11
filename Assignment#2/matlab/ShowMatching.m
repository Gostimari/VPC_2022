function ShowMatching(MatchList,img1,img2,Dscpt1,Dscpt2, Pts1, Pts2)
% Show all matches by ploting the line that connects both matched keypoints. 
% Create a composed image with the original and query image to plot the connected points.
% Allow also the possibility to visualise the 8x8 (or 5x5) feature patches
% per matching.
  
    if(size(img2,1)<size(img1,1))
        img2 = padarray(img2,[20 120],0,'post');
    end        
    img_m = cat(2,img1,img2); % colapse the two images in on plot
    dim = size(img1,2); % scale to use on the x coordenates to the second image

    figure;
    imshow(img_m, []);
    hold on;
    
    for i = 1:size(MatchList, 1)
        plot(Pts1.y(MatchList(i,1)), Pts1.x(MatchList(i,1)),'ro'); %show the image 1 key points
        plot(dim + Pts2.y(MatchList(i,2)), Pts2.x(MatchList(i,2)),'bo'); %show the image 2 key points
        plot([Pts1.y(MatchList(i,1)) Pts2.y(MatchList(i,2)) + dim], [Pts1.x(MatchList(i,1)) Pts2.x(MatchList(i,2))], 'g'); %draw a line between the key points matches
    end

    figure;
    flag = 1;
    for i = 1:size(MatchList,1)
        for j = 1:size(MatchList, 1)
            if j == MatchList(i,1)
                Dsc1 = imresize(Dscpt1(i,:), [8 8]); %recise the descriptor point to 8x8
                 
                %Print the descriptors in 3 colums and 2 rows on the same figure
    
                subplot(3,2,flag);
                imshow(Dsc1);
                flag = flag + 1;
            end
        end
        if flag == 7
            break
        end
    end
    
    figure;
    flag = 1;
    for i = 1:size(MatchList,1)
        for j = 1:size(MatchList, 1)
            if j == MatchList(i,2)
                 Dsc2 = imresize(Dscpt2(MatchList(i,2),:), [8 8]); %recise the descriptor point to 8x8
    
                 %Print the descriptors in 3 colums and 2 rows on the same figure
                 subplot(3,2,flag);
                 imshow(Dsc2);
                 flag = flag + 1;
            end
        end
        if flag == 7
            break
        end
    end

    hold off;

    pause(1);
end
        