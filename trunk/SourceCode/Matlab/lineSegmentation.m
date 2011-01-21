function [lines] = lineSegmentation(im)

% LINESEGMENTATION This function takes a black and white image and separates lines by creating 
% horizontal cuts. This will not work if the lines have a large skew

    % CONSTANT DECLARATIONS:
    PEAK_DELTA_FACTOR = 2;
    THRESHOLD = 1;

    % Transform the image in black and white
    bw = im2bw(im, 0.9);
    
    % Generate a histogram
    bw_trans = (bw(:,2:end) - bw(:,1:end-1)) ~= 0 ;
    im_hist = sum(bw_trans,2) ;

    % Find minima in histogram
    [max_peaks, min_peaks] = peakdet(im_hist, floor(max(im_hist)/PEAK_DELTA_FACTOR)); %#ok<ASGLU>

    % Plot the histogram
    figure, plot(im_hist);
    hold on; 
    plot(min_peaks(:,1), min_peaks(:,2), 'g*');
    h = legend('Histogram of lines', 'Significant Minima');

    % Plot the file with horizontal cuts
    x = 1:1:size(im,2);
    figure(10);
    imshow(im,[]);
    hold on
    plot(x, repmat(min_peaks(:,1), [1, size(im,2)]), '-r');

    cut_points = [min_peaks(:,1); size(im,1)];
    
    % Return a structure where every element is a line segmented
    lines = struct([]);
    
    prev = ones(size(min_peaks,1),1);
    % Loop over the lines
    for i = 1:size(cut_points,1)
        
        if i ~= 1
            prev(i) = cut_points(i-1);
        end
        
        % Extracted segment
        current_segm = bw(prev(i):cut_points(i),:);
        
        % We eliminate an eventually white part
        bw_trans = (current_segm(:,2:end) - current_segm(:,1:end-1)) ~= 0 ;
        segm_hist = sum(bw_trans,2) ;
        segm_logical_hist = segm_hist > THRESHOLD;
        points = find(segm_logical_hist);
        
        ascender_cut_point = points(1)-1;
        if ascender_cut_point == 0 
            ascender_cut_point = 1;
        end
        descender_cut_point = points(end) + 1; 
        
        % New Y coordinates 
        startY = prev(i) + ascender_cut_point;
        endY = prev(i) + descender_cut_point - 1;
        
        % Output of the function
        lines(i).originalImage = im(startY:endY, :, :);
        lines(i).bwImage = bw(startY:endY, :);
        lines(i).startY = startY;
        lines(i).endY = endY;
    end

end