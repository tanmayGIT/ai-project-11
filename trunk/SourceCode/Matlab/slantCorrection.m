function final_line = slantCorrection(line, angle)

    % We increase the image to avoid the black pixels of the transformation
    [h w d] = size(line);
    new_line = uint8(zeros(h, w*2, d));
    new_line(:) = 255;
    
    new_line(:, floor(w/2):floor(w/2) + w - 1, :) = line(:,:,:);
    
    % Transformation
    tf = [1 0 0; tand(90 - angle) 1 0; 0 0 1];
    tform = maketform('affine', tf);
    corrected_line = imtransform(new_line, tform);
        
    borders = extractBoundingBox(corrected_line);
    final_line = corrected_line(borders(3):borders(4), borders(1):borders(2));
    
%     % We extract the final line from the increased image
%     stepX = floor(0.1 * w);
%     final_line = corrected_line(:, floor(w/2) - stepX : 3*floor(w/2)-1 + stepX, :);
     
    figure, imshow(final_line,[]);
    title('After Slant Correction');

end