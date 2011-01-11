

im = imread('a01-000u.png');
im = im2bw(im);
lines = lineSegmentation(im);

for i = 1:size(lines,2)
    
    close all
    
    % Show all the lines
    imshow(lines(i).im);
    pause(0.3);
    
    
    % Skew correction
    [correctedLine, baseline] = skewCorrection(lines(i).im);
    lines(i).skew = correctedLine;
    lines(i).baseline = baseline;
    
    % Slant correction
    lines(i).angleSlant = slantDetection(lines(i).skew, baseline);
    lines(i).slant = slantCorrection(lines(i).skew, lines(i).angleSlant);
    
    
    
end
