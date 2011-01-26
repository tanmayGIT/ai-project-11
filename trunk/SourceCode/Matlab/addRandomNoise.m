%Adds some random noise to a feature vector for loops and dots
function new_features = addRandomNoise(features)

%dimension 4-9, 4-6 loops, 7-9 dots

percentage = 20;
indices = 1:size(features,2);

for d=4:9
    rand_idx = indices(randperm(size(features,2)));
    %Take the first n percent of random indices
    rand_idx = rand_idx(1:floor(size(features,2)/100*percentage));
    rand_noise = rand(size(features,2),1);
    features(d,rand_idx) = rand_noise(rand_idx);
end

end