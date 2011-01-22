function [features, word_features] = featureExtractionInWord(word)


    [num_dots, dots_position] = getDots(word);
    [num_junctions, junctions_position] = getJunctions(word);
    [num_endpoints, endpoints_position] = getEndpoints(word);
    [num_loops, loops_position] = getLoops(word);
    
    word_features.dots = dots_position;
    word_features.junctions = junctions_position;
    word_features.endpoints = endpoints_position;
    word_features.loops = loops_position;
    
    features = [num_dots; num_junctions; num_endpoints; num_loops];

end
