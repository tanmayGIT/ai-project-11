% Handwriting recognition
% Project AI, Januari 2011
% Davide Modolo, (Tocho Tochev, Niels Out?) Thijs Kooi

%We can have this function take as input an images of a word, a sentence or
%a document, depending on our approach
%If this is a function that classifies, we need to deliver a trained markov
%model. The training should be done in another function I guess.

%We want to make as clean, reusable code as possible, so lets make
%conventions about notation, functions in directories, etc. 

%Personally I denote functions as firstPartSecondPart and variables as
%first_part_second_part, it will be convenient if we all take this
%notation, but I'm open to other suggestions. Maybe its nice to put every
%subfunctionality of this pipeline in a subdirectory as well.

%Davide was also talking about a graphical interface. We extracted some
%usefull functions from last years group and where talking about extending
%with some extra image processing and possible implement an HMM ourselves
%in C++, along with transition probabilities for the HMM, extracted from
%maybe a corpus used in ELPL. 

function output = main(input)

    %sketch of a general pipeline, maybe we need more functions or we dont
    %need some of these, but we can always add, substract. At least it
    %gives us something to work with

    %Maybe we can do noise removal, etc depending on the method to use
    pre_processed_input = preProcessing(input);
    
    %Slant, skew, slope, vertical, horizontal normalisation, etc.
    normalised_input = normalisation(pre_processed_input);
    
    %Segmentation?
    segmented_letters = segmentation(normalised_input);
    
    %HMM
    output = classifyWords(segmented_letters);
    
end
