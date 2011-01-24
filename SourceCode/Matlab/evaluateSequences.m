%Assumes a set of observations and the trained word models and 
%will return for every observation the most likely word.

function evaluateObservations(observations,word_models)

likelihood = size(word_models,1);

for obs=1:size(observations,1)
    for word_model=1:size(word_models,1)
        evaluateObservation(word_models(word_model),observations(obs));
    end
end


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
