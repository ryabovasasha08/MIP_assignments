function [Ap, p] = padImg(A)
%
% PADIMG  Adds padding to the image.
%   Input:
%      A - initial image to be padded
%   Output:
%      Ap - an image, padded with a padding p of black color
%      p - size of padding (half of the biggest of the image dimensions)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A, 1);
n = size(A, 2);
p = max(m/2,n/2);
B = uint8(zeros(m+2*p, n+2*p));
B(1:p, :) = 0;
B(m+p:end, :) = 0;
B(:, 1:p) = 0;
B(:, n+p:end) = 0;
B((p+1):(p+m),(p+1):(p+n)) = A;
Ap = B;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA RIABOVA; SHRIYA JAIN; YASMEEN MAI HACK
