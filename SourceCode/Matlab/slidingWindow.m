function features = slidingWindow(width, interval, word_structure, word_features)


    features = zeros(size(word_structure.skeleton, 2) - width, 15);

    for i = 1:interval:size(word_structure.skeleton,2) - width
        current_window = word_structure.skeleton(:, i : (i + width - 1));
        features(i, :) = extractFeatures(current_window, i, word_structure, word_features)';
    end

end



function feature_vector = extractFeatures(current_window, pos, word_structure, word_features)
    
    imshow(current_window);
    drawnow;
    window_pos = pos:pos+size(current_window,2)-1;
    feature_vector = featuresInWindow(window_pos, word_structure, word_features);
    
end