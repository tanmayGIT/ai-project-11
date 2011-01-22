function [dots, pixels] = getDots(im)

% GETDOTS returns the number of dots present in the image and their
% position

    % Number of pixels for dots
    STROKE_MAX_LEN = 15;
    STROKE_MIN_LEN = 3;
    dots = 0 ;
    
    [connected_components, label_matrix] = bwboundaries(im);
    num_components = max(max(label_matrix));
    
    pixels = [];
    
    % Check if any of the components are dots
    for i = 1:num_components
        stroke = connected_components{i};
        sz = size(unique(stroke,'rows'),1);
        if sz <= STROKE_MAX_LEN && sz >= STROKE_MIN_LEN
            dots = dots + 1;
            pixels = [pixels; connected_components{i}];
            continue 
        end
    end

end