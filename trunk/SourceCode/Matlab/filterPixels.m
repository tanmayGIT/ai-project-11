function [filtered_x, filtered_y] = filterPixels(x, y, line)

    % Compute histograms of y values
    hist_pixels = zeros(size(line,1),1);
    for i = 1:length(y)
        hist_pixels(y(i)) = hist_pixels(y(i)) + 1;
    end
    
    % smooth histogram
%     SMOOTH_FACTOR = 10;
%     smoothHist = medfilt1(hist_pixels, ceil(size(hist_pixels,1)/SMOOTH_FACTOR));

    
    % Clustering
    if length(y) < 3
        return
    else
        clusters = kmeans(y, 3, 'emptyaction', 'drop');
    end
    
    threshold = 0.3 * length(y);
    filtered_x = [];
    filtered_y = [];
    count = 1;
    for i = 1:3
        if (sum(clusters == i) > threshold)
            temp_y = find(clusters == i);
            for j = 1:size(temp_y)
                filtered_x(count) = x(temp_y(j));
                filtered_y(count) = y(temp_y(j));
                count = count + 1;
            end
        end
    end
    
end