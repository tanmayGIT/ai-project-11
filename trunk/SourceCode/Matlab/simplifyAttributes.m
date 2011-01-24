function simplifyAttributes()

load allAttributes.mat;

attributes = struct2cell(lineAtts);

for i=1:size(attributes,1)
    text = struct2cell(attributes{i});
    for j=1:size(text,1)
        processAtt(text{j}.id);
    end
end


end

function processAtt(prefix)



end

