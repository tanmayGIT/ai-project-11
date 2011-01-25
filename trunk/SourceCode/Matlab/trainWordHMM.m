%Train a word model for the given word and return an HMM object
%
% 

function wordHMM = trainWordHMM(word,features,number_of_states,number_of_components)

    
    priors = initialisePriors(number_of_states);
    transition_probabilities = initialiseLeftToRightModel(number_of_states);
    mixture_matrix = initialiseMixtureMatrix(number_of_states,number_of_components);
    MU = initialiseMean(features{1}',number_of_states,number_of_components);
    SIGMA = initialiseCovariance(features{1}',number_of_states,number_of_components);

    [LL, new_priors, new_transition_probabilities, new_MU, new_SIGMA, new_mixture_matrix] = ...
        mhmm_em(features, priors, transition_probabilities, MU, SIGMA, mixture_matrix);

    wordHMM.word = word;
    wordHMM.number_of_states = number_of_states;
    wordHMM.number_of_components = number_of_components;
    wordHMM.likelihood = LL;
    wordHMM.prior_probabilities = new_priors;
    wordHMM.transition_probabilities = new_transition_probabilities;
    wordHMM.mixture_matrix = new_mixture_matrix;
    wordHMM.MU = new_MU;
    wordHMM.SIGMA = new_SIGMA;

end

function prior_probabilities = initialisePriors(number_of_states)

prior_probabilities = zeros(number_of_states,1);
prior_probabilities(1) = 1;

end

%Initialise the initial weights of the mixture components of every state
%uniformly
function mixture_matrix = initialiseMixtureMatrix(number_of_states,number_of_components)

    mixture_matrix = zeros(number_of_states,number_of_components);
    for i=1:number_of_states
        for k=1:number_of_components
            mixture_matrix(i,k) = 1/number_of_components;
        end
    end
    
end

%Initialise uniform left to right transition probabilities
function transition_probabilities = initialiseLeftToRightModel(number_of_states)

    transition_probabilities = zeros(number_of_states,number_of_states);
    for i=1:number_of_states-1
        transition_probabilities(i,i) = 0.5;
        transition_probabilities(i,i+1) = 0.5;
    end
    transition_probabilities(number_of_states,number_of_states) = 1.0;
end

%Initialises the mean of every mixture component at every state randomly
function MU = initialiseMean(features,number_of_states,number_of_components)

    MU = zeros(size(features,2),number_of_states,number_of_components);
    data_max = max(features);
    data_min = min(features);
    for j=1:number_of_states
        for k=1:number_of_components
            MU(:,j,k) = data_min+ (data_max-data_min) *diag(rand(size(features,2),1));
        end
    end
    
end

%Initialise covariance of mixture components
function SIGMA = initialiseCovariance(features,number_of_states,number_of_components)

    SIGMA = zeros(size(features,2),size(features,2),number_of_states,number_of_components);
    for i=1:number_of_states
        for k=1:number_of_components
            SIGMA(:,:,i,k) = eye(size(features,2),size(features,2));
        end
    end

end