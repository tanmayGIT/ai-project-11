lines = number;

for i=1:size(lines,2)
   
    fid = fopen(sprintf('letter%d.txt', i), 'w');
    for j = 1:size(lines(i).features,1)
        for k = 1:size(lines(i).features,2)
            fprintf(fid, '%f ', lines(i).features(j,k);
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
end