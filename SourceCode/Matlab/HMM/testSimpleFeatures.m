function testSimpleFeatures(letter,number)

number_of_states = 6;
number_of_components = 1;

letter_features = cell(size(letter,1), size(letter,2));
number_features = cell(size(letter,1), size(letter,2));

for ex=1:10
    letter_features{ex} = letter(ex).features';
    number_features{ex} = number(ex).features';
end

letterHMM = trainWordHMM('letter',letter_features,number_of_states,number_of_components);
numberHMM = trainWordHMM('number',number_features,number_of_states,number_of_components);

letter_log_likelihood = evaluateObservation(letterHMM,letter_features{2})
number_log_likelihood = evaluateObservation(numberHMM,letter_features{2})

end

%Evaluate observations, observations are assumed to be in dxN
function log_likelihood = evaluateObservation(wordModel,observations)

    obs_lik = zeros(wordModel.number_of_states,size(observations,2));
    for i=1:wordModel.number_of_states
        for t=1:size(observations,2)
            obs_lik(i,t) = mvnpdf(observations(:,t),wordModel.MU(:,i),wordModel.SIGMA(:,:,i));
        end
    end

    [alpha_letter, beta, gamma, log_likelihood, xi_summed, gamma2] = ...
        fwdback(wordModel.prior_probabilities, wordModel.transition_probabilities, obs_lik);

end

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
            MU(:,j,k) = data_min+ (data_max-data_min) *diag(rand(3,1));
        end
    end
    
end

%Initialise covariance of mixture components
function SIGMA = initialiseCovariance(features,number_of_states,number_of_components)

    SIGMA = zeros(size(features,2),size(features,2),number_of_states,number_of_components);
    for i=1:number_of_states
        for k=1:number_of_components
            SIGMA(:,:,i,k) = cov(features);
        end
    end

end