function [ Lines, width] = lineSegment(Img)
% LINESEGMENT This function takes an image and separates lines by creating 
% horizontal cuts. This will break horrifically if the lines have a large
% skew

% CONSTANT DECLARATIONS:
SMOOTH_FACTOR = 150;
PEAK_DELTA_FACTOR = 10;
SELECTION_THRESH=40;

Lines = [];

% Generate a histogram of negative image
ImgNeg = makeNegative(Img);
imgHist = sum(ImgNeg, 2)/size(ImgNeg,2);

% Smooth histogram with a 1-D Median filter
smoothHist = medfilt1(imgHist, ceil(size(imgHist,1)/SMOOTH_FACTOR));

% Find minima in smoothed histogram
[maxtab, mintab] = peakdet(smoothHist, floor(max(imgHist)/PEAK_DELTA_FACTOR));

% Plot the histogram
figure, plot(imgHist);
hold on; 
plot(mintab(:,1), mintab(:,2), 'g*');
h = legend('Histogram of paragraph','Significan Minima');

% Width
width = size(Img,2);

% Label connected components of image, just in case
ImgLabeled = bwlabel(ImgNeg);
ImgLabeledNC = bwlabel(ImgNeg);
% will use this for intersecting regions

% Loop over minima
for i=1:size(mintab,1)
    histIndex = mintab(i,1);
    
    % compute prev
    if (i==1)
        prev = 1;
    else
        prev = mintab(i-1,1);
    end;
    %i
    
    % check for components intersecting the cut
    if(imgHist(histIndex) == 0)
        % there are no intersecting components, thus a cut may be made here
        Lines(1:(histIndex+1-prev)*width,i) = reshape(makeNegative(Img(prev:histIndex,:))',(histIndex+1-prev)*width,1);
    else
        % there are intersecting regions, we must separate them
        % we analyze the center of mass of the connected components to
        % determine which line they belong to
        
        indices= ImgLabeled(histIndex,:)~=0;
        problemComponents=unique(ImgLabeled(histIndex,indices));
        
        
        %currentLine = ImgLabeled .* (ImgLabeled ~= problemComponents(j));
        components=unique(ImgLabeled(prev:histIndex,:));
        newLine = getCompLine(ImgLabeled, components);
        
        
        for j=1:size(problemComponents,2)
            %look at this connected component
            
            [ax,ay]=ait_centroid(ImgLabeled==problemComponents(j));
            height=(histIndex-prev)/8;
            if ay<(prev+height)
                % THIS COMPONENT BELONGS ON THE PREVIOUS LINE, DO NOT SHOW
                % IT
                %newLine = newLine - (ImgLabeled==problemComponents(j));

            elseif ay>(prev+height) && (ay<(histIndex-height))
                % THIS COMPONENT BELONGS ON THIS LINE, AND NOT OTHERS. SHOW
                % ENTIRE THING
                % cut out portions so they do not appear at top of next
                % line
                
                newLine = newLine + (ImgLabeled==problemComponents(j));
                ImgLabeled = ImgLabeled .* (ImgLabeled ~= problemComponents(j));
            else
                % THIS COMPONENT BELONGS ON THE NEXT LINE, DO NOT SHOW IT
                newLine = newLine - (ImgLabeled==problemComponents(j));
                
            end
        end
        [row,col]=find(newLine > 0);
        newLine = newLine(min(row):max(row),:);
        Lines(1:size(newLine,1)*width,i) = reshape(newLine',size(newLine,1)*width,1);
        % IMPLEMENT IF THERE IS TIME %
        % TEMPORARILY DO THE SAME THING AS OTHER CASE %
        
    end;
end;

end

