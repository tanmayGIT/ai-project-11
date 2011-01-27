function  [] = plotComponents(I)
    
    % Removes spur (isolated) pixels
    im = bwmorph(I,'spur');
    

    %   SHOW COMPONENTS WITH DIFFERENT COLORS    
    %     colors = ['w', 'b', 'g', 'r', 'k', 'm', y];
    colors = [[1 1 1]; [0 0 1]; [0 1 0]; [1 0 0]; [0 0 0]; [1 0 1]; [1 1 0]; [1.5 1.5 100]; [150 15 100];...
            [0 0 1]; [250 100 1]];

    [~, label_matrix] = bwboundaries(im);
    
    M = zeros(size(label_matrix,1), size(label_matrix,2), 3);
    for i = 1:size(label_matrix,1)
        for j = 1:size(label_matrix,2)
          M(i, j, :) = colors(label_matrix(i,j) + 1, :); 
        end
    end
    figure, subplot(1,3,1), imshow(I); subplot(1,3,2), imshow(im); subplot(1,3,3), imshow(M);
  
end

