function [ baselines ] = baselinePosition( inLine, lowerBaseline )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

GRADTHRESH = 1;
SMOOTH_FACTOR = 10;

% generate histogram
inHist = sum(inLine,2);

% smooth histogram
smoothHist = medfilt1(inHist, ceil(size(inHist,1)/SMOOTH_FACTOR));

% compute upper baseline
[lo, hi] = baselineHelper(smoothHist);
upperBaseline = (lo+hi)/2;

% compute upper and lower limits
histZeros = find(inHist == 0);
histZerosGrad = gradient(histZeros);
upperLowerLimits = histZeros(histZerosGrad > GRADTHRESH);

% plot histogram
% figure, plot(inHist);
% hold on;
% maxVal=max(inHist);
% plot([lowerBaseline lowerBaseline], [1 maxVal], 'r');
% plot([upperBaseline upperBaseline], [1 maxVal], 'm');
% plot([upperLowerLimits(1) upperLowerLimits(1)], [1 maxVal], 'g');
% plot([upperLowerLimits(2) upperLowerLimits(2)], [1 maxVal], 'g');

% draw on image
figure, imshow(inLine);
hold on;
plot([1 size(inLine,2)], [lowerBaseline lowerBaseline],'r');
plot([1 size(inLine,2)], [upperBaseline upperBaseline],'r');
plot([1 size(inLine,2)], [upperLowerLimits(1) upperLowerLimits(1)], 'g');
plot([1 size(inLine,2)], [upperLowerLimits(2) upperLowerLimits(2)], 'g');

baselines=[upperLowerLimits(1) upperBaseline lowerBaseline upperLowerLimits(2)];

% scale image vertically

end

