function [models] = pipeline()

  s = warning('off');
%   load markov_models.mat;
  load newANNOTATION.mat;

  train_set = 20;
  test_set = 5;
  
%   For every word in the training set
  for w_indx = 1:100
    fprintf('\nCURRENT WORD: %s \nImage: ', words{w_indx});
    for i = 1 : train_set
        
        fprintf(' %d ', i);
        % Read Image
        im = readImageFromDatabase(annotations{w_indx, i});
          
        % Preprocessing
        word_structure(i) = preProcessing(im);
          
        % Feature extraction
        [statistics, word_features] = featureExtractionInWord(word_structure(i).skeleton); %#ok<ASGLU>
        % Parameters
        width = 3;
        interval = 1;
        num_features = 12;
        features{i} = slidingWindow(width, interval, word_structure(i), word_features, num_features)';
      
%         noise_percentage = 20;
%         features{i} = addRandomNoise(features{i},noise_percentage);
    end
    
    % Train an HMM model for every word
    num_mixture_components = 1;                % Currently 1 
    number_of_states = length(words{w_indx});  % Equal to the length of the word
    models(w_indx) = trainWordHMM(words{w_indx}, features, number_of_states, num_mixture_components);
  end
   
%     disp('Evaluating results');
%   for w_indx=1:15
%       fprintf('\nCURRENT WORD: %s \nImage: ', words{w_indx});
%       for i = train_set + 1 : (train_set + test_set)
%         fprintf(' %d ', i);
%         % Read Image
%         im = readImageFromDatabase(annotations{w_indx, i});
%           
%         % Preprocessing
%         word_structure(i) = preProcessing(im);
%           
%         % Feature extraction
%         [statistics, word_features] = featureExtractionInWord(word_structure(i).skeleton); %#ok<ASGLU>
%         % Parameters
%         width = 3;
%         interval = 1;
%         test_features = slidingWindow(width, interval, word_structure(i), word_features)';
%             
%         %Evaluate the image againts every model, return a vector of words
%         %ordered by likelihood and another of corresponding likelihoods
%         [most_likely_words, likelihoods] = evaluateObservations(test_features, HHModels, words);
%           
%         ranked_words{w_indx, i - train_set} = most_likely_words;
%         ranked_likelihoods{w_indx, i - train_set} = likelihoods;
%       end
%   end
 
%   evaluateResults(ranked_words, ranked_likelihoods);
  
  
end