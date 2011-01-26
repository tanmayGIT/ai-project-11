function [image] = eliminateWhiteVerticalBorders(image)

      
      bw = im2bw(image, 0.8);
      invert_bw = invertBwImage(bw);
      im_hist = sum(invert_bw, 1);

      temp = find(im_hist ~= 0);
      
      border(1) = temp(1);
      border(2) = temp(end);
      
      image = image(:, border(1):border(2));
end