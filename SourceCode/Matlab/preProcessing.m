% LINES is a structure where every cell is a line of the text and 
% evey one of them have the following elements:
%
%       - originalImage :  original line
%       - bwImage       :  black and white image
%
%       - skewImage     :  image obtained after skew correction
%       - angleSlope    :  degrees of slope
%
%       - slantImage    :  image obtained after slant correction
%       - angleSlant    :  degrees of slant
%
%       - lowerBaseline :  lower baseline of the line
%       - upperBaseline :  upper baseline onf the line



im = imread('a01-000u.png');
% im = medfilt2(im);
lines = lineSegmentation(im);

for i = 1:size(lines,2)
    
    close all
    
    % Show all the lines
    imshow(lines(i).originalImage);
    pause(0.3);
    
    % Skew correction
    [correctedLine, slope, baseline] = skewCorrection(lines(i).bwImage);
    lines(i).skewImage = correctedLine;
    lines(i).angleSlope = slope;
    lines(i).lowerBaseline = baseline;
    
    lines(i).upperBaseline = upperBaselineEstimation(lines(i).skewImage);
    
    % Display line and baselines
    imshow(lines(i).skewImage);
    x = 1:1:size(lines(i).skewImage,2);
    hold on, plot(x, lines(i).lowerBaseline, '-b');
    hold on, plot(x, lines(i).upperBaseline, '-r');
    
    
    % Slant correction
    lines(i).angleSlant = slantDetection(lines(i).skewImage, baseline);
    lines(i).slant = slantCorrection(lines(i).skewImage, lines(i).angleSlant);
    
    
    
    % Skeleton 
    lines(i).skeleton = skeleton(lines(i).originalImage);
    
end


