function [lines] = lineSegmentation(im)

% LINESEGMENTATION This function takes an image and separates lines by creating 
% horizontal cuts. This will not work if the lines have a large skew

    % CONSTANT DECLARATIONS:
    PEAK_DELTA_FACTOR = 10;
    THRESHOLD = 1;

    % Generate a histogram
    bw = im2bw(im);
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

    % Return a structure where every element is a line segmented
    lines = struct([]);
    
    % Loop over the lines
    for i = 1:size(min_peaks,1)
        
        if i == 1
            prev = 1; 
        else
            prev = min_peaks(i-1);
        end
        
        % Extracted segment
        current_segm = im(prev:min_peaks(i),:);
        
        % We eliminate an eventually white part
        bw = im2bw(current_segm);
        bw_trans = (bw(:,2:end) - bw(:,1:end-1)) ~= 0 ;
        segm_hist = sum(bw_trans,2) ;
        segm_logical_hist = segm_hist > THRESHOLD;
        points = find(segm_logical_hist);
        ascender_cut_point = points(1)-1;
        descender_cut_point = points(end) + 1; 
        
        % New segment obtained reducing the previous one
        new_box = current_segm(ascender_cut_point:descender_cut_point,:);
        
        lines(i).im = new_box;
    end

end