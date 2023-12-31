function [B] = LPFilter(A, d)
%
% LPFILTER  Removes noise from image by converting it into Fourier space,
%           applying mask filter to truncate the highest frequencies 
%           and converting the image back into spacial domain.
%   Input:
%      A - initial image to be denoised
%      d - an array of two numbers that defines the width and length of
%      filter
%   Output:
%      B - a denoised image
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(A, 1);
N = size(A, 2);
A_Double = double(A);
A_Fourier = zeros(M, N);

for j = 1:M
    for l = 1:N
        sum = 0;
        for k = 1:M
            for n = 1:N
                sum = sum + A_Double(k, n) * exp(-1i*2*pi*((j-1)*(k-1)/M+(l-1)*(n-1)/N));
            end
        end
        A_Fourier(j, l) = sum/sqrt(M*N);
    end
end

A_Fourier_Shifted = fftshift(A_Fourier);

S = zeros(M, N);
for i = max(1, M/2-d(1)):min(M, M/2+d(1))
    for j = max(1, (N/2-d(2))):min(N, N/2+d(2))
        S(i, j) = 1;
    end
end

A_Fourier_Truncated = A_Fourier_Shifted.*S;
A_Fourier_Deshifted = ifftshift(A_Fourier_Truncated);

B = zeros(M, N, 'uint8');
for j = 1:M
    for l = 1:N
        sum = 0;
        for k = 1:M
            for n = 1:N
                sum = sum + A_Fourier_Deshifted(k, n) * exp(1i*2*pi*((j-1)*(k-1)/M+(l-1)*(n-1)/N));
            end
        end
        B(j, l) = real(sum/sqrt(M*N));
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA RIABOVA, SHRIYA JAIN, YASMEEN MAI HACK

