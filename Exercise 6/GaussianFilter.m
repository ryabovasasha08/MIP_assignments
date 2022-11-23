function [B, F] = GaussianFilter(A, t)
%
% GAUSSIANFILTER  Removes noise from image 
%           by applying Gaussian mask filter to smoothen high contrast.
%   Input:
%      A - initial image to be denoised
%      t - a parameter that defines width of the Gaussian filter
%   Output:
%      B - a denoised image
%      F - the normalized Gaussian filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A, 1);
n = size(A, 2);
W_t = ceil(3*sqrt(2*t));

% Step 1: pad image by reflecting its values by t at each side

A_padded = zeros(m+2*W_t+1, n+2*W_t+1);
A_padded(W_t+1:W_t+m, W_t+1:W_t+n) = double(A);
A_padded(1:W_t, W_t+1:n+W_t) = flip(A(1:W_t, :), 1);
A_padded(W_t+m+1:W_t*2+m+1, W_t+1:n+W_t) = flip(A(m-W_t:m, :), 1);
A_padded(:,1:W_t) = flip(A_padded(:, W_t+1:2*W_t), 2);
A_padded(:, W_t+n+1:W_t*2+n+1) = flip(A_padded(:, n:n+W_t), 2);

%figure('Name', 'check padded image:')
%imshow(A_padded)

% Step 2: construct a filter mask
F = zeros(W_t*2+1, W_t*2+1);
for i = -W_t:W_t
    for j = -W_t:W_t
        F(i+W_t+1, j+W_t+1) = exp(-(i*i+j*j)/(4*t));
    end
end

F_sum = sum( F , 'all' );
F = F/F_sum;

A_padded_filtered = imfilter(A_padded, F);
B = uint8(A_padded_filtered(W_t+1:W_t+m, W_t+1:W_t+m));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA_RIABOVA
