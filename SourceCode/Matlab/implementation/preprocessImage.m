function [ finalLines, segVecs ] = preprocessImage( inputImg )
%recognizeImage Take an input image and return text

% begin by converting to grayscale, if necessary
if (ndims(inputImg)==3)
    inputImg = rgb2gray(inputImg);
end
if (isempty(find((inputImg ~= 0) & (inputImg ~= 1), 1)))
    bwImg = inputImg;
else
    bwImg = im2bw(inputImg, graythresh(inputImg));
end

% segment into lines
[lines, width] = lineSegment(bwImg);

% handle how many lines?
%NUMLINES=size(lines,2);
NUMLINES=7;

finalLines = ones(90, width, NUMLINES);

for i=1:NUMLINES
    currentLine = generateLine(lines(:,i),width);
    [preSlant baseline] = skewCorrect(currentLine);
    clear currentLine;
    preBaseline = slantCorrect(preSlant);
    clear preSlant;
    baselineVector = baselinePosition(preBaseline,baseline);
    normalizedLine = scaleCorrect(preBaseline, baselineVector);
    clear preBaseline;
    clear baselineVector;
    wordSegVec = wordSegment(normalizedLine);
    finalLines(1:90,1:size(normalizedLine,2),i) = normalizedLine;
    clear normalizedLine;
    segVecs(1:size(wordSegVec,2),i) = wordSegVec;
end;


end