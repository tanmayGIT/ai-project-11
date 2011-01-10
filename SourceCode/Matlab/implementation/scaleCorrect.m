function [ outLine ] = scaleCorrect( inLine, baselineVector )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
baselineVector = round(baselineVector);

region1 = inLine(baselineVector(1):baselineVector(2),:);
region2 = inLine(baselineVector(2):baselineVector(3),:);
region3 = inLine(baselineVector(3):baselineVector(4),:);

width = size(region1,2);
resizeVector = [30 width];

region1 = imresize(region1, resizeVector);
region2 = imresize(region2, resizeVector);
region3 = imresize(region3, resizeVector);

outLine = [region1; region2; region3];

end

