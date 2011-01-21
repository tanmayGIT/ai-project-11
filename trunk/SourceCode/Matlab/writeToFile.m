lines = number;

for i=1:size(lines,2)
   
    fid = fopen(sprintf('number%d.txt', i), 'w');
    for j = 1:size(lines(i).features,1)
        fprintf(fid, '%f %f %f\n', lines(i).features(j,1), lines(i).features(j,2), lines(i).features(j,3));
    end
    fclose(fid);
end