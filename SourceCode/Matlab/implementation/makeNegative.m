function [ negImg ] = makeNegative( grayImg )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    negImg = im2double(grayImg);
    negImg = negImg .* -1;
    negImg = negImg +1;
    negImg = im2uint8(negImg);
end

