function [Match] = FeatureMatching(Dscpt1,Dscpt2,Tresh,Metric_TYPE)
    
    if (Metric_TYPE == "SSD")

        Match = [];
    
        SSD = zeros(size(Dscpt1,1), size(Dscpt2,1));
    
        % Calculates all the ssd
        for i=1:size(Dscpt1,1)
            for j=1:size(Dscpt2,1)
                SSD(i,j)=sum((Dscpt1(i,:)-Dscpt2(j,:)).^2);
            end
            j=1;
        end
        
        minSSD=min(SSD,[],2); %find the minimum distance
        
        for i=1:size(minSSD,1)
            [~,c]=find(SSD(i,:) == minSSD(i));
            
            if minSSD(i) < Tresh % when is less than thresh is a match
                Match = [Match;i c minSSD(i)];
            end
        end

    else

        Match = [];
    
        SSD = zeros(size(Dscpt1,1), size(Dscpt2,1));

        % Calculates all the ssd
        for i=1:size(Dscpt1,1)
            for j=1:size(Dscpt2,1)
                SSD(i,j)=sum((Dscpt1(i,:)-Dscpt2(j,:)).^2);
            end
            j=1;
        end
        
        minSSD=mink(SSD,2,2);
        SSDbest = minSSD(:,1);
        SSD2best = minSSD(:,2);
        
        % Calculates all the Ratio
        RT = SSDbest./SSD2best;
        
        for i=1:size(RT,1)
            [~,c]=find(SSD(i,:) == minSSD(i));
            if RT(i) < Tresh
                Match = [Match;i c minSSD(i)];
            end
    
        end

    end
    
end
        
        