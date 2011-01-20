function [endpoints] = getEndpoints(im)
    
% GETENDPOINTS. Return the number of endpoints presents in the image

    % Removes spur (isolated) pixels
    im = bwmorph(im,'spur');

    % Compute endpoints
    im_endpoints = bwmorph(im,'endpoints');
    endpoints = sum(sum(im_endpoints));

end