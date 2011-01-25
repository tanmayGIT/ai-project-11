classdef wordHMM
    % Hidden markov model object 
    properties 
        word                    %string of the word represented 
        log_likelihood          %current log likelihood of the model
        prior_probabilities
        transition_probabilities
        mixture_matrix
        MU
        SIGMA
    end
end