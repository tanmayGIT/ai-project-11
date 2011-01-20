function [loops] = getLoops(im)

% GETLOOPS returns the number of loops present in the image

    inv_im = invertBwImage(im);
    inv_im = double(inv_im);
    
    % Convolve with a gaussian kernel
    size = [3, 3];
    sigma = 1;
    filter = fspecial('gaussian', size, sigma);
    conv_im = imfilter(inv_im, filter, 'replicate');

    % Transform the image into black and white and invert it to the
    % original 'version' (colors of skeleton)
    conv_im = im2bw(conv_im, 0.8);
    im = invertBwImage(conv_im);

    % Trace region boundaries in binary image
    [B, L, N] = bwboundaries(im);
    
    % Number of loops
    loops = length(B) - N;
    
    % Display loops in green and the rest in red
    figure; imshow(im); hold on;
    for k = 1:length(B),
        boundary = B{k};
        if(k > N)
            plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
            
        else
            plot(boundary(:,2), boundary(:,1),'r','LineWidth',2);
        end
    end

end