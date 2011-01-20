function  [] = plotComponents(I)
    
    % Removes spur (isolated) pixels
    img = bwmorph(I,'spur');
    

    %   SHOW COMPONENTS WITH DIFFERENT COLORS    
    %     colors = ['w', 'b', 'g', 'r', 'k', 'm', y];
    colors = [[1 1 1]; [0 0 1]; [0 1 0]; [1 0 0]; [0 0 0]; [1 0 1]; [1 1 0]];

    M = zeros(size(label_matrix,1), size(label_matrix,2), 3);
    for i = 1:size(label_matrix,1)
        for j = 1:size(label_matrix,2)
          M(i, j, :) = colors(label_matrix(i,j) + 1, :); 
        end
    end
    figure, subplot(1,3,1), imshow(I); subplot(1,3,2), imshow(img); subplot(1,3,3), imshow(M);
  
end

