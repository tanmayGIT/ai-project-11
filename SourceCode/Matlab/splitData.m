%Splits the data in a training and test set

function [training_set, test_set ] = splitData(annotation)

%We have 35 instances of each of the 395 words

    for word=1:295
        for i=1:20
            training_set{word,i} = annotation{word,i};
        end
        for i=1:10
            test_set{word,i} = annotation{word,20+i};
        end
    end

end