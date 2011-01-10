function [ outLine ] = slantCorrect( inLine )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%STEPSIZE IN DEGREES
STEPSIZE = 5;
THRESHOLD = 0.9;

maxI = 0;
angle = 0;

for i=-45:STEPSIZE:45
    % shear image at angle i
    tf = [1 0 0; tand(i) 1 0; 0 0 1];
    tform = maketform('affine', tf);
    slantLine = imtransform(inLine, tform);
    
    % compute vertical spatial histogram & wvd intensity
    histData = sum(slantLine,1);
    [a,b,c] = wvd(histData,1,floor(size(histData,2)/2));
    intensity = sum(sum(a))/(size(a,1)*size(a,2));

    if(intensity > maxI)
        maxI = intensity;
        angle = i;
    end
end;
    tf = [1 0 0; tand(angle) 1 0; 0 0 1];
    tform = maketform('affine', tf);
    outLine = imtransform(inLine, tform);
    outLine = (im2double(outLine) > THRESHOLD);
end