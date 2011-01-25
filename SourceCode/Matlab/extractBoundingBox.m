function [borders] = extractBoundingBox(in_line, param)

    % borders   (1): left
    %           (2): rigth
    %           (3): top
    %           (4): down
    
    % param:    1 -> only vertical cuts
    %           2 -> both vertical and horizontal cuts
    
    THRESHOLD = 0.05;

    [h, w, d] = size(in_line);
    bw_line = im2bw(in_line, 0.7);
    
    % Extract the vertical and horizonal center lines
    horizontal = bw_line(round(h/2),:); 
    
    % Evaluate their pixels
    hor = find(horizontal ~= 1);
    [hh, wh, dh] = size(hor);
    
    left = false;
    right = false;
    c = 1;
    
    % Extract the left and right borderss
    while ~left || ~right
        
        if hor(c) ~= c && ~left
            left = true;
            borders(1) = hor(c); % - round(THRESHOLD * w);
        end
        
        if hor(wh - c + 1) ~= w - c + 1 && ~right
            right = true;
            borders(2) = hor(wh - c + 1);% + round(THRESHOLD * w);
        end
        c = c + 1;
    end
    
    reduced_line = bw_line(:,borders(1):borders(2));
    
    
    if param == 2
        % Extract the top and down borders
        inv_line = invertBwImage(reduced_line);
        im_hist = sum(inv_line,2);
        ver = find(im_hist == min(im_hist));
        
        i = 1;

        while ver(i) + 1 == ver(i + 1)
            i = i + 1;
        end

        borders(3) = ver(i) - 1;
        
        i = size(ver,1);
        while ver(i) - 1 == ver(i - 1)
            i = i - 1;
        end
        
        borders(4) = ver(i) + 1;
    else
        borders(3) = 1;
        borders(4) = size(in_line,1);
    end
    
    borders(1) = borders(1)  - round(THRESHOLD * w);
    if borders(1) < 1 
        borders(1) = 1;
    end
    borders(2) = borders(2)  + round(THRESHOLD * w);
    if borders(2) >  size(in_line,2)
        borders(2) = size(in_line,2);
    end
    
    if borders(3) == 0
        borders(3) = 1;
    end
        
end