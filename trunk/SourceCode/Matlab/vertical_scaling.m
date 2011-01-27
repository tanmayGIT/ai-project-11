% scale sentences to h
% upper_baseline: upper baseline
% lower_baseline: lower baseline
% asy: upper boundary
% dsy: lower boundary

function im = vertical_scaling(im, upper_baseline, lower_baseline, h)
    
    norm_height1 = floor(h / 3); 
    norm_height2 = norm_height1;
    norm_height3 = h - 2 * norm_height1;
    w = size(im, 2) ;
        
    ascender = im(1:upper_baseline-1,:) ;
    mid = im(upper_baseline:lower_baseline-1,:) ;
    descender = im(lower_baseline:end,:) ;
    
    normAsc = imresize(ascender, [norm_height1, w]);
    normMid = imresize(mid, [norm_height2, w]);
    normDsc = imresize(descender, [norm_height3, w]);
    
    im = cat(1, normAsc(1:end,:), normMid(1:end,:), normDsc(1:end,:)) ;
    
%     x = 1:1:size(im,2);
%     imshow(im);
%     hold on, plot(x, norm_height1, 'b');
%     hold on, plot(x, norm_height1+norm_height3, 'r');
    
end