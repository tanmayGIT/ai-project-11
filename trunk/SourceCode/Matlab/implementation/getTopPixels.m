function [x,y] = getTopPixels( inLine )
x=[];
y=[];

count = 1;
% iterate horizontally
for i=1:size(inLine,2)
    temp = 0;
    j=1;
    % iterate from bottom to top until we reach top or set pixel
    while(temp==0 && j<size(inLine,1))
        j=j+1;
        temp = inLine(j,i);
    end;
    % record position
    if(j < size(inLine,1))
        x(count) = i;
        y(count) = j;
        count = count+1;
    end
end;