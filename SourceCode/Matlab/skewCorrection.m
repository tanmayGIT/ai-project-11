function [final_line, slope, baseline] = skewCorrection(line)

% SKEWCORRECT. This function takes a line as input and it returnes a new 
% line with corrected skew and the baseline.

    [x, y] = getLowerPixels(line);
      
    % Filter irrelevant pixels (those could create noise)
    [x, y] = filterPixels(x, y, line);

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
    
   
    % To avoid the black corners of rotation make the image bigger
    [h w d] = size(line);
    new_line = uint8(zeros(h*2, w*2, d));
    new_line(:) = 255;
    new_line(floor(h/2) : floor(h/2) + h - 1, floor(w/2) : floor(w/2) + w - 1, :) = line(:,:,:);
    
    
    % Rotate image
    corrected_line = imrotate(new_line, slope);
    
%     close all,
%     stepX = floor(0.15 * w);
%     stepY = floor(0.15 * h);
%     final_line = corrected_line(floor(h/2) - stepY : 3*floor(h/2)-1 + stepY, floor(w/2) - stepX : 3*floor(w/2)-1 + stepX, :);
% %     imshow(final_line);

    
    borders = extractBoundingBox(corrected_line, 2);
    final_line = corrected_line(borders(3):borders(4), borders(1):borders(2));

    
    % Compute the new baseline
    [x,y] = getLowerPixels(final_line);
    [x, y] = filterPixels(x, y, final_line);
    p = polyfit(x, y, 1);
    f = polyval(p, x_axis);
    
    baseline = f(ceil(size(f,2) / 2));
         
    % Show the image and baseline
    x_axis = (1:1:size(final_line,2));
    figure(6), imshow(final_line);
    hold on, plot(x_axis, baseline, 'r');
    title('Line with skew corrected and baseline plotted'); 
    scatter(x,y,'x');

end