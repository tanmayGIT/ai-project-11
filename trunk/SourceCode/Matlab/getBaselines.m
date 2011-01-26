function [upper_baseline, ascender_baseline, descender_baseline, lower_baseline] = getBaselines(word, lower_baseline)

      % Compute upper Baseline
      upper_baseline = upperBaselineEstimation(word);
      
      % Compute Ascender and Descender Baselines      
      bw = im2bw(word, 0.8);
      invert_bw = invertBwImage(bw);
      im_hist = sum(invert_bw, 2);

      temp = find(im_hist ~= 0);
      
      ascender_baseline = temp(1);
      descender_baseline = temp(end);
      
      if descender_baseline < lower_baseline
          lower_baseline = descender_baseline;
      end
end
