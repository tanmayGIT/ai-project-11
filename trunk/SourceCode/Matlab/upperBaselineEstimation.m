function [baseline] = upperBaselineEstimation(line)


    [x, y] = getUpperPixels(line);
%     [x, y] = filterPixels(x, y, line);
    
    % Linear regression
    p = polyfit(x, y, 1);

    width = size(line,2);

    % Show the image and baseline
    x_axis = (1:1:width);
    f = polyval(p, x_axis);
    
    baseline = f(ceil(size(f,2) / 2)) - 3;
    
    
    figure(5), imshow(line);
    hold on;
    plot(x_axis, baseline, 'r');
    scatter(x, y, 'x');
    title('Linear regression (red line) of the upper pixels (blue points)');

    

%     bw_trans = (line(2:end,:) - line(1:end-1,:)) ~= 0 ;
%     % generate histogram
%     im_hist = sum(bw_trans,2);
% 
%     % smooth histogram
%     SMOOTH_FACTOR = 10;
%     smoothHist = medfilt1(im_hist, ceil(size(im_hist,1)/SMOOTH_FACTOR));
% 
%     % compute upper baseline
%     baseline = baselineHelper(smoothHist);


end

