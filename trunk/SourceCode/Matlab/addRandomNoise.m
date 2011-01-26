%Adds some random noise to a feature vector for loops and dots
function features = addRandomNoise(features,percentage)

%dimension 4-9, 4-6 loops, 7-9 dots
indices = 1:size(features,2);

for d=4:9
    rand_idx = indices(randperm(size(features,2)));
    %Take the first n percent of random indices
    rand_idx = rand_idx(1:floor(size(features,2)/100*percentage));
    rand_noise = rand(size(features,2),1);

    for i=1:size(rand_idx,1)
        features(d,rand_idx(i)) = features(d,rand_idx(i))+rand_noise(rand_idx(i));
    end
end

end