function [ img ] = generateLine( lineCol, width )
%GENERATELINE This function takes a column vector and reshapes it into an
%image
img = reshape(lineCol, width, size(lineCol,1)/width)';

end

