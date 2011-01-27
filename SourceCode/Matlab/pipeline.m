% function [models] = pipeline()

  s = warning('off');
%   load markov_models.mat;
%     load models_with_noise.mat;
    load newANNOTATION.mat;
    load models_1_and_5.mat;

  train_set = 30;
  test_set = 5;
  
% %   For every word in the training set
%   for w_indx = 1:195
%     fprintf('\nCURRENT WORD: %s \nImage: ', words{w_indx});
%     for i = 1 : train_set
%         
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
%         num_features = 12;
%         features{i} = slidingWindow(width, interval, word_structure(i), word_features, num_features)';
%       
%         noise_percentage = 20;
%         features{i} = addRandomNoise(features{i}, noise_percentage);
%     end
%     % Train an HMM model for every word
%     num_mixture_components = 5;                % Currently 1 
%     number_of_states = length(words{w_indx});  % Equal to the length of the word
%     models(w_indx) = trainWordHMM(words{w_indx}, features, number_of_states, num_mixture_components);
%   end
%    
    disp('Evaluating results');
  for w_indx=1:195
      fprintf('\nCURRENT WORD: %s \nImage: ', words{w_indx});
      for i = train_set + 1 : (train_set + test_set)
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
            
        %Evaluate the image againts every model, return a vector of words
        %ordered by likelihood and another of corresponding likelihoods
        num_features = 12;
        test_features = slidingWindow(width, interval, word_structure(i), word_features, num_features)';
        
        [most_likely_words, likelihoods] = evaluateObservations(test_features, models_1g, words);
        
        ranked_words1{w_indx, i - train_set} = most_likely_words;
        ranked_likelihoods1{w_indx, i - train_set} = likelihoods;
      end
      
    save ranked_words1
    save ranked_likelihoods1
  end
  
%   save ranked_words1
%   save ranked_likelihoods1
%   
%       disp('Evaluating results');
%   for w_indx=1:195
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
%             
%         %Evaluate the image againts every model, return a vector of words
%         %ordered by likelihood and another of corresponding likelihoods
%         num_features = 12;
%         test_features = slidingWindow(width, interval, word_structure(i), word_features, num_features)';
%         
%         [most_likely_words, likelihoods] = evaluateObservations(test_features, models_5g, words);
%         
%         ranked_words2{w_indx, i - train_set} = most_likely_words;
%         ranked_likelihoods2{w_indx, i - train_set} = likelihoods;
%       end
% %     save ranked_words2
% %     save ranked_likelihood2
%   end
%  
%   save ranked_words2
%   save ranked_likelihood2
% %   evaluateResults(ranked_words, ranked_likelihoods, words);
%   
%   k = 10;
% % end
