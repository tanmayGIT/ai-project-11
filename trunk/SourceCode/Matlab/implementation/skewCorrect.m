function [ outLine, baseline ] = skewCorrect( inLine )
%SKEWCORRECT This function takes a line 

%     ETHRESH = 15;

% find bottom pixels and compute regression
[x,y] = getBottomPixels(inLine);
p = polyfit(x,y,1);

width = size(inLine,2);

% debug output, display in image and angled baseline
%x=(1:1:width);
%f=polyval(p,x);

%figure,imshow(inLine);
%hold on;
%plot(x,f,'r');

% compute angle, rotate image and display
slope = atan(p(1))*180/pi;
outLine = imrotate(inLine,slope);


%hack to get the new baseline
[x,y] = getBottomPixels(outLine);
p = polyfit(x,y,1);

%display rotated image with baseline
% figure,imshow(outLine);
% hold on;
% line([1,width],[p(2),p(2)],'Color','r');

baseline = p(2);

end