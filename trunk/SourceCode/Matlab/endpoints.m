function g = endpoints(f)

% ENDPOINTS computes end points of a binary image f and returns them in a
% binary image g

    persistent lut
    
    if isempty(lut)
        lut = makelut(@endpoint_fcn, 3);
    end
    
    g = applylut(f, lut);

end


function is_end_point = endpoint_fcn(nhood)

% ENDPOINT_FCN determines if a pixel is an end point
% 
% IS_END_POINT = ENDPOINT_FCN(NHOOD) accepts a 3-by-3 binary neighborhood,
% NHOOD, and returns a 1 if the center element is an end point, otherwise
% it returns 0

    is_end_point = nhood(2,2) & (sum(nhood(:)) == 2);

end