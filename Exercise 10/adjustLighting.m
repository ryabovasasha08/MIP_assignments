function [B, par] = adjustLighting(A)
%
% ADJUSTLIGHTNING  equalizes illumination of the greyscale image
%   Input:
%      A - initial grayscale image with uneven lightning to be equalized
%   Output:
%      B - initial image with adjusted lightning
%      par - solution of the LSP in form of coefficients a,b,c, that
%      determine the light plane
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A, 1);
n = size(A, 2);

A = double(A);
z = reshape(A, [m*n, 1]);
B = zeros(m*n,3);
B(:, 1) = repmat(1:m, 1, n).'.^2;
B(:, 2) = reshape(repmat(1:1:m, n, 1), [m*n, 1]);
B(:, 3) = ones(n*m, 1);
par = B\z;

v = zeros(m, n);
for i = 1:m
    for j = 1:n 
        v(i, j) = par(1)*i*i+par(2)*j+par(3);
    end
end

u = A - v;

maxu = max(max(u));
minu = min(min(u));
for i = 1:m
    for j = 1:n 
        u(i, j) = (u(i,j) - minu)/(maxu-minu) * 255;
    end
end

figure('Name', 'Lighting on image')
imshow(uint8(v))

B = uint8(u);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA RIABOVA, YASMEEN MAI HACK, SHRIYA JAIN
