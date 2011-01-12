function [skeleton] = skeleton(im)

%     filter_size = [3 3];
%     sigma = 1;
%     h = fspecial('gaussian', filter_size, sigma); 
%     
%     I = double(im);
%     smoothed_im = conv2(I, h);
%      
%     skeleton = im2bw(smoothed_im, 0.01);
%     figure, imshow(skeleton);
    
    
    
    filter_size = 10;
    sigma = 3;
    h = fspecial('gaussian', filter_size, sigma); 
    g = imfilter(im, h, 'replicate');
    g = im2bw(g, 1.5*graythresh(g));
    
    I = double(im);
    
    smoothed_im = conv2(I, h);
     
    skeleton = im2bw(smoothed_im, 0.01);
    figure, imshow(skeleton);
    
    im = bwmorf(im, 'skel', Inf);
    
end