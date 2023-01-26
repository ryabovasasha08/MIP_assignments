function [B] = inpaintRect(A, R, d, N)
%
% Input:
%   A: original image
%   R: indicies of rectangular region missing in A
%   d: width of low pass filter
%   N: number of iterations for the low pass filter to be applied
%
% Output:
%   B: new image with the region R now inpainted
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mean_U = 0;
sum = 0;
[C] = zeros(size(A));
A = double(A);

%compute mean value of boundary pixels
for i = R(1) - 1:R(2)+1
    mean_U = mean_U + 2;
    sum = sum + A(i,R(3)-1);
    sum = sum + A(i,R(4)+1);

end

for j = R(3):R(4)
    mean_U = mean_U + 2;
    sum = sum + A(R(1) - 1,j);
    sum = sum + A(R(2) + 1,j);
end

m = sum/(mean_U - 4);

%initializing R to the mean
for i = R(1):R(2)
    for j = R(3):R(4)
        A(i,j) = m;
    end
end

for i = 1:size(A,1)
    for j = 1:size(A,2)
        B(i,j) = A(i,j);
    end
end

%apply low pass filter only to R for N iterations

for iter = 1:N
    [C] = LPFilter(B,d);
    for i = R(1):R(2)
        for j = R(3):R(4)
            B(i,j) = C(i,j);        %assign filtered image back to R then iterate again
        end
    end
end

B = uint8(B);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by Yasmeen Mai Hack
