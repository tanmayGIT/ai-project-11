function [ wordSegVector ] = wordSegment( lineImg )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%lineImg = makeNegative(lineImg);

% trim whitespace off left/right sides
[row,col]=find(lineImg > 0);
lineImg = lineImg(:,min(col):max(col));
%figure, imshow(lineImg);
imgHist = sum(lineImg, 1)/size(lineImg,1);
%SMOOTH_FACTOR = 4;
%imgHist = medfilt1(imgHistOld, ceil(size(imgHistOld,1)/SMOOTH_FACTOR));
%figure, plot(imgHist);

startPts = [1];
stopPts = 0;
startIdx = 2;
stopIdx = 1;
for i=1:size(imgHist,2)-1,
    if(imgHist(i) > 0 && imgHist(i+1) == 0)
        stopPts(stopIdx) = i;
        stopIdx = stopIdx+1;
    end;
    
    if(imgHist(i) == 0 && imgHist(i+1) > 0)
        startPts(startIdx) = i;
        startIdx = startIdx+1;
    end;
end;
stopPts(stopIdx) = size(lineImg,2);

%being lazy and using matlab image functions on standard matrices to do
%k-means clustering
stopPts = [1, stopPts];
startPts = [startPts, size(lineImg,2)];
widths = startPts-stopPts;
maxWidth = max(widths);

 widths = widths/maxWidth;
% 
 imageSpaces = im2bw(widths, graythresh(widths));
 startPts = startPts .* imageSpaces;
 stopPts = stopPts .* imageSpaces;
% 
% %remove zeros
 startPts = startPts(startPts~=0);
 stopPts = stopPts(stopPts~=0);
 stopPts(size(stopPts,2)+1) = size(lineImg,2);


figure, imshow(lineImg);
hold on
points = [1];
for i=1:size(startPts,2),
    plot([startPts(i) startPts(i)], [1 90], 'g');
    plot([stopPts(i) stopPts(i)], [1 90], 'r');
    points = [points stopPts(i) startPts(i)];
end;
wordSegVector=[points size(lineImg,2)];


end
