function [words] = extractAnnotation()

    % Read the file
    [filenames, gt] = textread('Annotation.txt', '%s %s');

    % Words in the vocabulary
    vocabulary = unique(gt);

    % Sort the words in alphabetic order
    [B,IX] = sort(gt);
    count = 1;

    % Compute Frequencies
    frequencies = ones(size(vocabulary));
    for i = 1:size(gt,1)    
        if i ~= size(gt,1)
            if strcmp(B{i+1}, B{i})
                 frequencies(count) = frequencies(count) + 1;
            else
                count = count + 1;
            end
        else 
            frequencies(count) = frequencies(count) + 1; 
        end
    end


    % Filter words based on frequency
    MIN_FREQUENCY = 35;
    accepted_words_indx = find(frequencies > MIN_FREQUENCY);
    accepted_words = vocabulary(accepted_words_indx);

    words = {};
    for i = 1:size(accepted_words,1)
         found = false;
         next = 1;
         for j = 1:size(B,1) 
             if strcmp(B{j}, accepted_words(i))
                   words{i, next} = filenames(IX(j));
                   next = next + 1;
                   found = true;
                   if next == MIN_FREQUENCY + 1
                       break
                   end
             else
                 if found == true
                     break
                 end
             end
         end
    end

end




