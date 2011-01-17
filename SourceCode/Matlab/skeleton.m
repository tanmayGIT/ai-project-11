function [sk_im] = skeleton(im)

    filter_size = 3;
    sigma = 0.3;
    h = fspecial('gaussian', filter_size, sigma); 
    g = imfilter(im, h, 'replicate');
    g = im2bw(g, graythresh(g));
    inv_g = invertBwImage(g);
    sk_im = bwmorph(inv_g, 'skel', Inf);
    imshow(sk_im);
    
end