function [Match] = RatioFeatureMatcher(Desc1,Desc2)

Match = []; %List to store all the matches
SSD=zeros(size(Desc1,1),size(Desc2,1));

% Calculates all the ssd
for i=1:size(Desc1,1)
    for j=1:size(Desc2,1)
        SSD(i,j)=sum((Desc1(i,:)-Desc2(j,:)).^2);
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
    Match = [Match;i c minSSD(i)];
end

end

