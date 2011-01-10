function [ loBaseline,upBaseline ] = baselineHelper( smoothHist )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
MINSLOPE=0.75;

histoDXDY = gradient(smoothHist);
[maxVal, maxIdx] = max(histoDXDY);

i=maxIdx;
while(histoDXDY(i)>MINSLOPE)
    i=i+1;
end;

upBaseline = i;
i=maxIdx;
while(histoDXDY(i)>MINSLOPE)
    i=i-1;
end;
loBaseline = i;

end

