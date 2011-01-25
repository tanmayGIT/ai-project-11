function [sk_im] = skeleton(im)

    filter_size = 3;
    sigma = 0.3;
    h = fspecial('gaussian', filter_size, sigma); 
    
    g = imfilter(im, h, 'replicate');
    g = im2bw(g, graythresh(g));
    inv_g = invertBwImage(g);
    
    sk_im = bwmorph(inv_g, 'skel', Inf);
%     figure
%     subplot(1,3,1), imshow(inv_g);
%     subplot(1,3,2), imshow(sk_im);
    
    for k = 1:5
        sk_im = sk_im & ~endpoints(sk_im);
    end
    
%     subplot(1,3,3), imshow(sk_im);
    
end