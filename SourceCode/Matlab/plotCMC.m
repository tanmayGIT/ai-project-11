function plotCMC(ranks)

%test_ranks = [1,3,4,5,7,3,5,1,1,2,3,5,9,8,10,1,3];

cummulative_rank = zeros(size(ranks));
cummulative_rank(1) = size(find(ranks == 1),2);

    for i=2:size(ranks,2)
        cummulative_rank(i) = cummulative_rank(i-1)+size(find(ranks == i),2);
    end

    cummulative_rank = cummulative_rank./size(ranks,2);
    
%     plot(cummulative_rank);
    
end