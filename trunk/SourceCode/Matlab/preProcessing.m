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
        
    % Compute upper, ascender and descender baselines (and eventually
    % update the lower one)
    [upp, asc, desc, low] = getBaselines(word.slantImage, word.lowerBaseline);
    word.upperBaseline = ceil(upp);
    word.ascenderBaseline = asc;
    word.descenderBaseline = desc;
    word.lowerBaseline = low;
         
    % Cut the image at ascender and descender baselines
    word.cut = word.slantImage(word.ascenderBaseline : word.descenderBaseline, :);
    word.newUpperBaseline = word.upperBaseline - word.ascenderBaseline;
    word.newLowerBaseline = word.lowerBaseline - word.ascenderBaseline;
    
    % Cut the left and right borders of the image (eliminate lateral white parts)
    word.cut = eliminateWhiteVerticalBorders(word.cut);

    % Skeleton 
    word.skeleton = skeleton(word.cut);
    
end
    


