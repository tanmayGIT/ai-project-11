function pipeline(annotation,words)

  %Read training files
  disp('Splitting data in training and test set...');
  [training_set, test_set] = splitData(annotation,words);
  disp('Done!');
  
  %For every word in the training set
  for word=1:295
    for i=1:size(training_set,1)
      %Do Preprocessing
      
      %Do feature extraction
      
      %Add all instances of the word to a structure
    end
    
    %feed the structure of all instances to an HMM
    %trainWordHMM(word,features,number_of_states,number_of_mixture_componen
    %ts)
    models(word) = trainWordHMM(words{1},features,size(words{1},2),1);
  end
   
  
  for word=1:295
      for i=1:size(test_set,1)
          %Do preprocessing
          
          %Do feature extraction
            
          %Evaluate the image againts every model, return a vector of words
          %ordered by likelihood and another of corresponding likelihoods
          [most_likely_words, likelihoods] = evaluateObservations(test_features,models,words);
          
          ranked_words{word,i} = most_likely_words;
          ranked_likelihood{word,i} = likelihoods;
      end
  end
 
  evaluateResults(ranked_words,ranked_likelihoods);
  
  
end