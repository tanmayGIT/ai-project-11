function [features] = featureExtraction(im)


    [num_dots, dots_positions] = getDots(im);
    [num_junctions, junction_positions] = getJunctions(im);
    [num_endpoints, endpoints_positions] = getEndpoints(im);
    [num_loops, loops_positions] = getLoops(im);
    
    features = [num_dots; num_junctions; num_endpoints; num_loops];

end