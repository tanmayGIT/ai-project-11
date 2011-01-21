function [endpoints, pixels] = getEndpoints(im)
    
% GETENDPOINTS returns the number of endpoints present in the image

    % Removes spur (isolated) pixels
    im = bwmorph(im,'spur');

    % Compute endpoints
    im_endpoints = bwmorph(im,'endpoints');
    [row, col] = find(im_endpoints == 1);
    pixels = [row, col];
    endpoints = size(row,1);
    
end