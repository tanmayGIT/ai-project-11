function correctedLine = slantCorrection(line_bw, angle)

    % To avoid the black corners of rotation we first invert the image
    [line_wb] = invertBwImage(line_bw);

    % Transformation
    tf = [1 0 0; tand(90 - angle) 1 0; 0 0 1];
    tform = maketform('affine', tf);
    outLine = imtransform(line_wb, tform);
    
    % To avoid the black corners of rotation we now bring the image back
    [correctedLine] = invertBwImage(outLine);
    
    figure, imshow(correctedLine,[]);

end