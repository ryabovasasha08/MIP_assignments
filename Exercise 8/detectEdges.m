function [B] = detectEdges(A, t, sigma)
%
% DETECTEDGES  detects edges of the greyscale image
%   Input:
%      A - initial grayscale image with edges to be detected
%      t = [t1,t2] - an array with threshold values for hysteresis thresholding
%      sigma - a parameter for Gaussian blurring
%   Output:
%      B - a black/white images with white pixels at the edge points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A, 1);
n = size(A, 2);

% Step 1: Pre-smooth the image A with a Gaussian filter

A = double(A);
A = imgaussfilt(A,sigma);
 
% Step 2: apply Sobel filter

Sobel_x = [[-1 0 1]; [-2 0 2]; [-1 0 1]]/8;
Sobel_y = Sobel_x.';
grads_x = conv2(A,Sobel_x,'same');
grads_y = conv2(A, Sobel_y, 'same');
grads_norms = sqrt((grads_y.*grads_y)+(grads_x.*grads_x));
grads_angles = asin(grads_y./grads_norms);
% rounding angles to the 45 degrees multiple
grads_angles = round(grads_angles/(pi/4))*pi/4;

% if norm of gradient is 0, then division by 0 gives NaN in grads_angles. It
% doesn't matter, replace it with any integer, say 0
grads_angles(isnan(grads_angles))=0;

% Step 3: non-maximum suppression

candidates = zeros(m,n);

for i = 2:m-1
    for j = 2:n-1
        diff = [0 0];
        switch grads_angles(i,j)
            case  - pi/4
                diff = [-1 -1];
            case pi/4
                diff = [1 1];
            otherwise
                diff = [round(sin(grads_angles(i,j))) round(cos(grads_angles(i,j)))]; 
        end
        norm_plus_neighbor = grads_norms(i+diff(1), j+diff(2));
        norm_minus_neighbor = grads_norms(i-diff(1), j-diff(2));
        if grads_norms(i, j) >= max(norm_plus_neighbor, norm_minus_neighbor)
            candidates(i,j) = 1;
        end
    end
end

% Step 4: Hysteresis Thresholding

for i = 1:m
    for j = 1:n
        if candidates(i, j) == 1
            if grads_norms(i, j)<=t(1)
                candidates(i,j) = 0;
            end
            if grads_norms(i, j)<=t(2) && grads_norms(i, j)>t(1)
                candidates(i,j) = 0.5;
            end
        end
    end
end

% Step 5: detecting edge by connected components

is_edge_point = zeros(n, m, 'uint8');
CC = bwconncomp(A);

for k = 1:CC.NumObjects
    cc_indexes = CC.PixelIdxList{k};
    for index = 1:size(cc_indexes, 1)
        if is_edge_point(index) == 0
            if candidates(index) == 1
                is_edge_point(cc_indexes) = 255;
            end
        end        
    end
end

B = uint8(is_edge_point);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA_RIABOVA
