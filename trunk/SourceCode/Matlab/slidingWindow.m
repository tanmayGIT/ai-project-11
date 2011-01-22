function features = slidingWindow(skeleton_im, width, interval, word_str, word_features)

feature_dimension = width;
features = zeros(size(skeleton_im,2)-width, 15);

    for i=1:interval:size(skeleton_im,2)-width
        current_window = skeleton_im(:,i:i+width-1);
        features(i,:) = extractFeatures(current_window, i, skeleton_im, word_str, word_features)';
    end

end

function feature_vector = extractFeatures(current_window, pos, skeleton_im, word_str, word_features)
    imshow(current_window);
    drawnow;
    window_pos = pos:pos+size(current_window,2)-1;
    feature_vector = featuresInWindow(window_pos, skeleton_im, word_str, word_features);
end