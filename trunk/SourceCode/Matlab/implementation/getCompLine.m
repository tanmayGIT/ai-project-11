function [ outImg ] = getCompLine( image, components )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[x,y] = size(image);
outImg = zeros(x,y);
for i=1:size(components,1)
    if(components(i) > 0)
    outImg = outImg + (image == components(i));
    end
end
outImg = outImg > 0;

end

