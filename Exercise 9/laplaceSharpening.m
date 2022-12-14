function [B] = laplaceSharpening(A, tau, N)
%
% LAPLACESHARPENING  
%   Input:
%      A - initial grayscale image
%      tau - sharpening parameter
%      N - number of consecutive sharpening operations
%   Output:
%      B - a sharpened image
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = double(A);
m = size(A, 1);
n = size(A, 2);
Laplacian = [0 1 0; 1 -4 1; 0 1 0];
for iter = 1:N
    lapl = conv2(A, Laplacian, 'same');
    A = A - tau*lapl;
    k_max = max(max(max(A)), 255);
    k_min = min(min(min(A)), 0);
    A = (A - k_min)/(k_max-k_min) * 255;
end
B = uint8(A);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA_RIABOVA
