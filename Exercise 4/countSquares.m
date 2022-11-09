function [N] = countSquares(A)
%
% COUNTSQUARES  Counts amount of black squares on the picture with size 1..20.
%   Input:
%      A - initial image with black squares to be counted on white
%      blackground
%   Output:
%      N - an array of numbers, where element with index i corresponds to
%      the number of black squares of size i*i on the image A
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = [];
A = imcomplement(A);
maxSquareSize = 20;
for s=maxSquareSize:-1:1
    B = strel('square', s); % structuring element
    A_op = imdilate(imerode(A, B), B); % A o B
    N(maxSquareSize-s+1) = sum(A_op,'all')/(s*s*255);
    A = A-A_op;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA RIABOVA, SHRIYA JAIN, YASMEEN MAI HACK


