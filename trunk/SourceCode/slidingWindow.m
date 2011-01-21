function features = slidingWindow(image, width,interval)

feature_dimension = 40;
features = zeros(size(image,2)-width,feature_dimension);

    for i=1:interval:size(image,2)-width
        frame = image(:,i:i+width-1);
        features(i,:) = extractFeatures(frame);
    end

end

function feature_vector = extractFeatures(frame)
    imshow(frame);
    drawnow;
    feature_vector = sum(frame,1);
end