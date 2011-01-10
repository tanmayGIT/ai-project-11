function [y, tmin, tmax] = wvd(z, res, fa)

%WVD Wigner-Ville time-frequency distribution.
%
%  USAGE:    y=wvd(x,res,fa)
%            or
%            [y,min_t,max_t]=tfd(...)
%  INPUT:
%   x     -  Complex input signal (column- or row vector).
%            If signal is real use hilbert(x).
%   res   -  Number of samples between the windows.
%            Good value: res=1
%   fa    -  Length of frequency axis.
%            (Default value: half the signal length.)
%  OUTPUT:
%   y     -  Contains the distribution. Each row represents
%            a frequency, each column a time instant.
%   min_t -  first time-instant of distribution
%   max_t -  final time-instant of distribution
%
%
%                /
%  Author:   Rene Laterveer, R.Laterveer@fel.tno.nl
%  Ref:   -  B. Boashash, "Time- Frequency Signal Analysis, methods and
%            applicatoions", Chapter 7, Wiley Halsted Press (1992)

%
% This software may be freely used and modified for research and development
% purposes. If you wish to use it for commercial gain please contact me.
% I provide absolutely NO WARRANTY for this software.
%                  /
%   Copyright: Rene Laterveer
%

nplts = floor(length(z)/res);

% make even for two transforms at once
nplts = floor(nplts/2)*2;

% make window length nearest odd integer to fa
lwin = 2*floor((fa-1)/2)+1;
hlf  = (lwin+1)/2-1;

tmin = 1;
tmax = length(z);

% zero padding to remove wrap around problems
z = [zeros(1,lwin-1), z, zeros(1,lwin-1)];

y = zeros(nplts,fa);

R = zeros(1, fa);
idx = 1:hlf;

for n=0:nplts/2-1

  t = 2*n*res+lwin;
  R(1) = z(t)*conj(z(t)) + i*z(t+res)*conj(z(t+res));
  v1 = z(t+idx).*conj(z(t-idx));
  v2 = z(t+res+idx).*conj(z(t+res-idx));
  R(idx+1) = v1+i*v2;
  R(fa-idx+1) = conj(v1)+i*conj(v2);

  RF = fft(R, fa);

  y(2*n+1,:) = real(RF);
  y(2*n+2,:) = imag(RF);

end

y = y.';
