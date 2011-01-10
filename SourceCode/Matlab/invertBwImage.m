function [inverted_bw] = invertBwImage(bw)

    inverted_bw = bw;
    inverted_bw(bw == 1) = 0;
    inverted_bw(bw == 0) = 1;

end