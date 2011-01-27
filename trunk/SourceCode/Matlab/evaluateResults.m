function evaluateResults(ranked_words, ranked_likelihoods,ground_truth)

first_correct = 0;
second_correct = 0;

%Compute percentage correct:
for word_idx=1:size(ranked_words,1)
    for instance=1:size(ranked_words,2)
        if(strcmp(ranked_words{word_idx,instance}(1),ground_truth(word_idx)) == 1 )
            first_correct = first_correct+1;
            second_correct = second_correct+1;
        end
        if(strcmp(ranked_words{word_idx,instance}(2),ground_truth(word_idx)) == 1 )
            second_correct = second_correct+1;
        end
    end
end


first_correct = first_correct/(size(ranked_words,1)*size(ranked_words,2))
second_correct = second_correct/(size(ranked_words,1)*size(ranked_words,2))

current_ranks = zeros(size(ranked_words,1),size(ranked_words,2));

for word_idx = 1:size(ranked_words,1)
    for instance = 1:size(ranked_words,2)
        logical = strcmp(ranked_words{word_idx,instance},ground_truth{word_idx});
        current_ranks(word_idx,instance) = find(logical == 1);
    end
end

for instance = 1:size(ranked_words,2)
    cummulative_ranks(instance,:) = plotCMC(current_ranks(:,instance),ground_truth);
end

plot(mean(cummulative_ranks,1));


end