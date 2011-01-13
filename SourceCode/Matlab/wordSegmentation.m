function [words] = wordSegmentation(line)

% wordsEGMENTATION This function takes an line and separates words by creating 
% horizontal cuts. 

    % Generate a histogram
    bw = im2bw(line);
    bw_trans = (bw(2:end,:) - bw(1:end-1,:)) ~= 0 ;
    hist_line = sum(bw_trans, 1) ;

    % Find cut points
    cut_points = findWordsCutPoints(hist_line, line);
    
    % Extract the words
    for i = 1:size(cut_points,1)
        words(i).bwImage = line(:, cut_points(i,1):cut_points(i,2));
    end
    
    % Display the segmented words
    figure;
    for i = 1:9
        subplot(3, 3, i), imshow(words(i).bwImage); 
    end 

end


% [words] = wordSegmentation(lines(10).originalImage);