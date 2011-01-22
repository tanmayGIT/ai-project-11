function [junctions, pixels] = getJunctions(im)
 
% GETJUNCTIONS returns the number of junctions present in the image

    % junction points less than THRESHOLD will be ignored
    THRESHOLD = 3 ;  
    
    % Removes spur (isolated) pixels
    im = bwmorph(im,'spur');
    
    im = [zeros(1,size(im,2)); im; zeros(1,size(im,2))];
    im = [zeros(size(im,1),1), im, zeros(size(im,1),1)];
    
    I = find(im > 0);
    [R,C] = ind2sub(size(im),I);
    junctions = 0;
    last = [inf,inf];
    count = 1;
    for i = 1 : size(R,1)
        r = R(i) ;
        c = C(i) ;
        conn = sum(sum(im(r-1:r+1,c-1:c+1))) - 1;
        
        % More than 2 connections:
        if conn > 2
            current = [r,c];
            if pdist([current;last]) < THRESHOLD
                continue
            else
                junctions = junctions + 1;
                last = [r,c];
                pixels(count, :) = last;
                count = count + 1;
            end
        end
    end
end