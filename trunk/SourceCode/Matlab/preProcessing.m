% LINES is a structure where every cell is a line of the text and 
% evey one of them have the following elements:
%
%       - originalImage :  original line
%       - bwImage       :  black and white image
%
%       - skewImage     :  line obtained after skew correction
%       - angleSlope    :  degrees of slope
%
%       - slantImage    :  line obtained after slant correction
%       - angleSlant    :  degrees of slant
%
%
%       - words         : all the words segmented from the line
%                         every word have different elements:
%
%           - originalImage :  original words
%           - bwImage       :  black and white word
%
%           - skewImage     :  word obtained after skew correction
%           - angleSlope    :  degrees of slope
%
%           - slantImage    :  word obtained after slant correction
%           - angleSlant    :  degrees of slant
%
%           - lowerBaseline :  lower baseline of the word
%           - upperBaseline :  upper baseline onf the word



% im = imread('a01-000u.png');
% im = medfilt2(im);
im = imread('sentence.png');
lines = lineSegmentation(im);

for i = 1:size(lines,2)
    
    close all
    
    % Show all the lines
    imshow(lines(i).originalImage);
    pause(0.3);
    
    % Skew correction
    [corrected_line, slope, baseline] = skewCorrection(lines(i).originalImage);
    lines(i).skewImage = corrected_line;
    lines(i).angleSlope = slope;
    lines(i).lowerBaseline = baseline;
    
    
    
    % Slant correction
    lines(i).angleSlant = slantDetection(lines(i).skewImage);
    lines(i).slant = slantCorrection(lines(i).skewImage, lines(i).angleSlant);
    
    
    
    % Skeleton 
    lines(i).skeleton = skeleton(lines(i).slant);
    
    close all,
    lines(i).words = wordSegmentation(lines(i).slant);
    
    for j = 1:size(lines(i).words)
        [corrected_word, slope, baseline] = skewCorrection(lines(i).words(j).originalImage);
        lines(i).words(j).skewImage = corrected_word;
        lines(i).words(j).angleSlope = slope;
        lines(i).words(j).lowerBaseline = baseline;
        
        lines(i).words(j).upperBaseline = upperBaselineEstimation(lines(i).words(j).skewImage);

        % Display line and baselines
        imshow(lines(i).words(j).skewImage);
        x = 1:1:size(lines(i).words(j).skewImage,2);
        hold on, plot(x, lines(i).words(j).lowerBaseline, '-b');
        hold on, plot(x, lines(i).words(j).upperBaseline, '-r');

        lines(i).words(j).angleSlant = slantDetection(lines(i).words(j).skewImage);
        if lines(i).words(j).angleSlant ~= 0
            lines(i).words(j).slant = slantCorrection(lines(i).words(j).skewImage, lines(i).words(j).angleSlant);
        end
    end
    
end
    


