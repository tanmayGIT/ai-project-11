function word = preProcessing(im)

    word = {};

    % Skew correction
    [corrected_line, slope, baseline] = skewCorrection(im);
    word.skewImage = corrected_line;
    word.angleSlope = slope;
    word.lowerBaseline = floor(baseline);
    
    % Slant correction
    word.angleSlant = slantDetection(word.skewImage);
    if word.angleSlant ~= 0
        word.slantImage = slantCorrection(word.skewImage, word.angleSlant);
    else
        word.slantImage = word.skewImage;
    end
        
    % Compute upper, ascender and descender baselines
    [upp, asc, desc] = getBaselines(word.slantImage, word.lowerBaseline);
    word.upperBaseline = ceil(upp);
    if ceil(asc) > 0
        word.ascenderBaseline = ceil(asc);
    else 
        word.ascenderBaseline = 1;
    end

    if floor(desc) < size(word.slantImage,1)
        word.descenderBaseline = floor(desc);
    else
        word.descenderBaseline = size(word.slantImage,1);
    end
         
    % Cut the image at ascender and descender baselines
    word.cut = word.slantImage(word.ascenderBaseline : word.descenderBaseline, :);
    word.newUpperBaseline = word.upperBaseline - word.ascenderBaseline;
    word.newLowerBaseline = word.lowerBaseline - word.ascenderBaseline;
        
    % Vertical Scaling
%     h = 100;
%     word.scaling = vertical_scaling(word.cut, word.newUpperBaseline, word.newLowerBaseline, h);
%     word.newUpperBaseline = floor(h/3);
%     word.newLowerBaseline = 2 * floor(h/3);

    % Extract the image (eliminate white pixels)
%     param = 2;
%     [borders] = extractBoundingBox(word.scaling, param);
%     word.extract = word.scaling(borders(3):borders(4),borders(1):borders(2));
    % Skeleton 
    word.skeleton = skeleton(word.cut);
    
end
    


