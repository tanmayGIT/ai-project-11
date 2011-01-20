function [words] = wordSegmentation(line)

% wordsEGMENTATION This function takes an line and separates words by creating 
% horizontal cuts. 

    % Generate a histogram
    bw = im2bw(line, 0.7);
%     bw_trans = (bw(2:end,:) - bw(1:end-1,:)) ~= 0 ;
    inv_bw = invertBwImage(bw);
    hist_line = sum(inv_bw, 1) ;
% close all
%     imshow(inv_bw);
    
    % Find cut points
    cut_points = findWordsCutPoints(hist_line, line);
    
    % Extract the words
    for i = 1:size(cut_points,1)
        words(i).originalImage = line(:, cut_points(i,1):cut_points(i,2));
        words(i).bwImage = bw(:, cut_points(i,1):cut_points(i,2));
    end
    
    % Display the segmented words
    close all 
    figure;
    for i = 1:9
        subplot(3, 3, i), imshow(words(i).originalImage); 
    end 

end