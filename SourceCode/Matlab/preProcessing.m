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
%
%           - skeleton      :  skeleton of the word



% im = imread('a01-000u.png');
% im = medfilt2(im);
im = imread('test_ppt.png');
% im = imread('hello.png');
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
    lines(i).slantImage = slantCorrection(lines(i).skewImage, lines(i).angleSlant);
    
    close all,
    lines(i).words = wordSegmentation(lines(i).slantImage);
    
    for j = 1:size(lines(i).words)
        
        % Correct skew/slope
        [corrected_word, slope, baseline] = skewCorrection(lines(i).words(j).originalImage);
        lines(i).words(j).skewImage = corrected_word;
        lines(i).words(j).angleSlope = slope;
        lines(i).words(j).lowerBaseline = floor(baseline);

        % Correct slant
%         lines(i).words(j).angleSlant = slantDetection(lines(i).words(j).skewImage);
%         if lines(i).words(j).angleSlant ~= 0
%             lines(i).words(j).slantImage = slantCorrection(lines(i).words(j).skewImage, lines(i).words(j).angleSlant);
%         else 
            lines(i).words(j).slantImage = lines(i).words(j).skewImage;
%         end
        
        % Compute upper, ascender and descender baselines
        [upp, asc, desc] = getBaselines(lines(i).words(j).slantImage, lines(i).words(j).lowerBaseline);
        lines(i).words(j).upperBaseline = ceil(upp);
        lines(i).words(j).ascenderBaseline = ceil(asc);
        lines(i).words(j).descenderBaseline = floor(desc);
        
        % Display word and baselines
        imshow(lines(i).words(j).slantImage);
        x = 1:1:size(lines(i).words(j).slantImage,2);
        hold on, plot(x, lines(i).words(j).lowerBaseline, 'b');
        hold on, plot(x, lines(i).words(j).upperBaseline, 'r');
        hold on, plot(x, lines(i).words(j).ascenderBaseline, 'm');
        hold on, plot(x, lines(i).words(j).descenderBaseline, 'g');
         
        % Cut the image at ascender and descender baselines
        lines(i).words(j).cut = lines(i).words(j).slantImage(lines(i).words(j).ascenderBaseline:lines(i).words(j).descenderBaseline, :);
        lines(i).words(j).newUpperBaseline = lines(i).words(j).upperBaseline - lines(i).words(j).ascenderBaseline;
        lines(i).words(j).newLowerBaseline = lines(i).words(j).lowerBaseline - lines(i).words(j).ascenderBaseline;
        
        % Vertical Scaling
        h = 100;
        lines(i).words(j).scaling = vertical_scaling(lines(i).words(j).cut, lines(i).words(j).newUpperBaseline, lines(i).words(j).newLowerBaseline, h);
        
        % Skeleton 
        lines(i).words(j).skeleton = skeleton(lines(i).words(j).scaling);
    end
    
end
    


