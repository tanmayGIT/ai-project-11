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
        word.slantImage = word.skew;
    end
        
    % Compute upper, ascender and descender baselines
    [upp, asc, desc] = getBaselines(word.slantImage, word.lowerBaseline);
    word.upperBaseline = ceil(upp);
    word.ascenderBaseline = ceil(asc);
    word.descenderBaseline = floor(desc);
         
    % Cut the image at ascender and descender baselines
    word.cut = word.slantImage(word.ascenderBaseline : word.descenderBaseline, :);
    word.newUpperBaseline = word.upperBaseline - word.ascenderBaseline;
    word.newLowerBaseline = word.lowerBaseline - word.ascenderBaseline;
        
    % Vertical Scaling
    h = 100;
    word.scaling = vertical_scaling(word.cut, word.newUpperBaseline, word.newLowerBaseline, h);

    % Skeleton 
    word.skeleton = skeleton(word.scaling);
    
end
    


