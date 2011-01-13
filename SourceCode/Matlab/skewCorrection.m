function [correctedLine, slope, baseline] = skewCorrection(line)

% SKEWCORRECT. This function takes a line as input and it returnes a new 
% line with corrected skew and the baseline.

    bw = im2bw(line);
    [x, y] = getLowerPixels(bw);
      
    % Filter irrelevant pixels (those could create noise)
%     [x, y] = filterPixels(x, y, line);

    % Linear regression
    p = polyfit(x, y, 1);

    width = size(line,2);

    % Show the image and baseline
    x_axis = (1:1:width);
    f = polyval(p, x_axis);
    figure(5), imshow(line);
    hold on;
    plot(x_axis, f, 'r');
    scatter(x, y, 'x');
    title('Linear regression (red line) of the lower pixels (blue points)');

    % Compute angle
    slope = atan(p(1))*180/pi;
    
   
    % To avoid the black corners of rotation we first invert the image
    [inverted_bw] = invertBwImage(line);
    
    % Rotate image
    invertedCorrectedLine = imrotate(inverted_bw, slope);

    % To avoid the black corners of rotation we now invert the image back
    [correctedLine] = invertBwImage(invertedCorrectedLine);
    
    % Compute the new baseline
    [x,y] = getLowerPixels(correctedLine);
%     [x, y] = filterPixels(x, y, correctedLine);
    p = polyfit(x, y, 1);
    f = polyval(p, x_axis);
    
    baseline = f(ceil(size(f,2) / 2));
       
    % Display rotated image with baseline
%     
%     figure(6), imshow(correctedLine);
%     hold on
%     plot(x_axis, f, 'r');
%     title('Line with skew corrected and baseline plotted');
%     
    figure(6), imshow(correctedLine);
    hold on, plot(x_axis, baseline, 'r');
    title('Line with skew corrected and baseline plotted'); 

end