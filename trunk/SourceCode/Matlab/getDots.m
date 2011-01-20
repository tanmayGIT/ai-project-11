function [dots] = getDots(im)

% GETDOTS. Return the number of dots presents in the image

    % Number of pixels for dots
    STROKE_MAX_LEN = 15;
    STROKE_MIN_LEN = 3;
    dots = 0 ;
    
    [connected_components, label_matrix] = bwboundaries(im);
    num_components = max(max(label_matrix));
    
    % Check if any of the components are dots
    for i = 1:num_components
        stroke = connected_components{i};
        sz = size(unique(stroke,'rows'),1);
        if sz <= STROKE_MAX_LEN && sz >= STROKE_MIN_LEN
            dots = dots + 1;
            continue 
        end
    end

end