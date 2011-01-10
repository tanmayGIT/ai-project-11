function [ outLine, baseline ] = skewCorrection(line)

% SKEWCORRECT. This function takes a line as input and it returnes a new 
% line with corrected skew and the baseline.

    bw = im2bw(line);

    [x, y] = getLowerPixels(bw);
    
    % Linear regression
    p = polyfit(x, y, 1);

    width = size(line,2);

    % Debug output, display in image and angled baseline
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
    [inverted_bw] = invertBwImage(bw);
    
    % Rotate image
    invertedOutLine = imrotate(inverted_bw, slope);

    % To avoid the black corners of rotation we now invert the image back
    [outLine] = invertBwImage(invertedOutLine);
    
    % Compute the new baseline
    [x,y] = getLowerPixels(outLine);
    p = polyfit(x, y, 1);

    % Display rotated image with baseline
    f = polyval(p, x_axis);
    figure(6), imshow(outLine);
    hold on
    plot(x_axis, f, 'r');
    title('Line with skew corrected and baseline plotted');
%     line([1,width],[p(2),p(2)],'Color','r');

    baseline = p(2);

end