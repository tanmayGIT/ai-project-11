function [features] = featureExtraction(im)


    num_dots = getDots(im);
    num_junctions = getJunctions(im);
    num_endpoints = getEndpoints(im);
    num_loops = getLoops(im);
    
    features = [num_dots; num_junctions; num_endpoints; num_loops];

end