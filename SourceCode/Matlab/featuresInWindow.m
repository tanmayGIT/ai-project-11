function [features_vector] = featuresInWindow(window_pos, word, word_features)

    % word = word structure (i.e. lines(10).words(12))

    skeleton_im = word.skeleton;
    h = size(skeleton_im,1);
    ws = size(window_pos,2);
    features_vector = [];
    

    %% INTENSITY 
    tot_intensity = sum(sum(skeleton_im(:, window_pos(1):window_pos(ws)),1)) / (h * ws);
    asc_intensity = sum(sum(skeleton_im(1:word.newUpperBaseline, window_pos(1):window_pos(ws)),1)) / (h * ws);
    med_intensity = sum(sum(skeleton_im(word.newUpperBaseline:word.newLowerBaseline, window_pos(1):window_pos(ws)), 1)) / (h * ws); 
    desc_intensity = sum(sum(skeleton_im(word.lowerBaseline:h, window_pos(1):window_pos(ws)),1)) / (h * ws); 
    
    features_vector = [features_vector, asc_intensity, med_intensity, desc_intensity];
    
%     %% REGIONS HIGH
%     asc_high = word.upperBaseline / h;
%     med_high = (word.lowerBaseline - word.upperBaseline) / h;
%     desc_high = (h - word.lowerBaseline) / h;
%     
%     features_vector = [features_vector, asc_high, med_high, desc_high];
%         
    %% LOOPS
    tot_loops = 0;
    asc_loops = 0;
    med_loops = 0;
    desc_loops = 0;
    
    % Check if we have more than one dots (in that case the loops are in
    % cells)
    if iscell(word_features.loops)
        end_for = size(word_features.loops,2);
    else
        if isempty(word_features.loops)
            end_for = 0;
        else
            end_for = 1;
        end
    end
    
    for i = 1 : end_for;
        
        if iscell(word_features.loops)
            loops_f = word_features.loops{i};
        else
            loops_f = word_features.loops;
        end
        
        x_loop = unique(loops_f(:,2));

        if sum((x_loop >= window_pos(1)) & (x_loop <= window_pos(ws))) > 0

            % We have a loop
            tot_loops = tot_loops + 1;

            % Check in which part of the image
            X = x_loop(find(((x_loop >= window_pos(1)) & (x_loop <= window_pos(ws)))==1));
            y_pos = unique(loops_f((find(loops_f(:,2) == X(1))),1));
            y_mean = mean(y_pos);

            % Save position
            if y_mean <= word.upperBaseline
                asc_loops = asc_loops + 1;
            else
                if y_mean <= word.lowerBaseline 
                    med_loops = med_loops + 1;
                else
                    desc_loops = desc_loops + 1;
                end
            end

        end
    end
    features_vector = [features_vector, asc_loops, med_loops, desc_loops];
    
    
    %% DOTS
    tot_dots = 0;
    asc_dots = 0;
    med_dots = 0;
    desc_dots = 0;
    
    if iscell(word_features.dots)
        end_for = size(word_features.dots,2);
    else
        if isempty(word_features.dots)
            end_for = 0;
        else
            end_for = 1;
        end
    end
    
    for i = 1 : end_for;
        
        if iscell(word_features.dots)
            dots_f = word_features.dots{i};
        else
            dots_f = word_features.dots;
        end
        
        x_dots = unique(dots_f(:,2));

        if sum((x_dots >= window_pos(1)) & (x_dots <= window_pos(ws))) > 0

            % We have a dot
            tot_dots = tot_dots + 1;

            % Check in which part of the image
            X = x_dots(find(((x_dots >= window_pos(1)) & (x_dots <= window_pos(ws)))==1));
            y_pos = unique(dots_f((find(dots_f(:,2) == X(1))),1));
            y_mean = mean(y_pos);

            % Save position
            if y_mean <= word.upperBaseline
                asc_dots = asc_dots + 1;
            else
                if y_mean <= word.lowerBaseline 
                    med_dots = med_dots + 1;
                else
                    desc_dots = desc_dots + 1;
                end
            end

        end
    end
    features_vector = [features_vector, asc_dots, med_dots, desc_dots];
    
    
    
    %% ENDPOINTS
    tot_endpoints = 0;
    asc_endpoints = 0;
    med_endpoints = 0;
    desc_endpoints = 0;
    
    end_for = size(word_features.endpoints, 1);
    
    for i = 1 : end_for;
        
        x_endpoints = word_features.endpoints(i,2);

        if sum((x_endpoints >= window_pos(1)) & (x_endpoints <= window_pos(ws))) > 0

            % We have an endpoint
            tot_endpoints = tot_endpoints + 1;

            % Check in which part of the image
            y_pos = word_features.endpoints(i,1);

            % Save position
            if y_pos <= word.upperBaseline
                asc_endpoints = asc_endpoints + 1;
            else
                if y_pos <= word.lowerBaseline 
                    med_endpoints = med_endpoints + 1;
                else
                    desc_endpoints = desc_endpoints + 1;
                end
            end

        end
    end
    features_vector = [features_vector, asc_endpoints, med_endpoints, desc_endpoints];


    
    %% JUNCTIONS
    tot_junctions = 0;
    asc_junctions = 0;
    med_junctions = 0;
    desc_junctions = 0;
    
    end_for = size(word_features.junctions, 1);
    
    for i = 1 : end_for;
        
        x_junctions = word_features.junctions(i,2);

        if sum((x_junctions >= window_pos(1)) & (x_junctions <= window_pos(ws))) > 0

            % We have an endpoint
            tot_junctions = tot_junctions + 1;

            % Check in which part of the image
            y_pos = word_features.junctions(i,1);

            % Save position
            if y_pos <= word.upperBaseline
                asc_junctions = asc_junctions + 1;
            else
                if y_pos <= word.lowerBaseline 
                    med_junctions = med_junctions + 1;
                else
                    desc_junctions = desc_junctions + 1;
                end
            end

        end
    end
    features_vector = [features_vector, asc_junctions, med_junctions, desc_junctions];
    
end