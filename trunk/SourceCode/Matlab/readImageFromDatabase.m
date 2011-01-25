function im = readImageFromDatabase(string)

    [matchstr, ~] = regexp(string, '\-', 'split');

    first_level = matchstr{1,1}(1);
    second_level = strcat(matchstr{1,1}(1), '-', matchstr{1,1}(2));
    third_level = strcat(second_level, '-', matchstr{1,1}(3), '-', matchstr{1,1}(4));
    

    im = imread(sprintf('%s%s%s%s%s%s%s%s%s.png', '..', filesep, 'Database', filesep, first_level{1}, filesep, second_level{1}, filesep, third_level{1}));

end