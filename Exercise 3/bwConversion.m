function [B, t] = bwConversion(A, method)
%
% BWCONVERSION  Converts grayscale image to black&white image.
%   Input:
%      A - initial image to be converted into black&white
%      method - a string, that defines the method of conversion and has two
%      values: 'median' or 'otsu'
%   Output:
%      B - a black&white version of original image
%      t - a threshold
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = size(A, 1);
n = size(A, 2);
DoubleA = double(A);
B = zeros(m, n, 'uint8');

if method == "median"
    t = median(DoubleA, 'all');
else
    if method == "otsu"
        [pixelCount, ~] = imhist(A);
        G = zeros(1, 256);
        for s=1:256
            weight1 = sum(pixelCount(1:s), 'all');
            weight2 = sum(pixelCount((1+s):256), 'all');
    
            mean1 = 0;
            for i=1:s
                mean1=mean1+pixelCount(i)*i;
            end
            mean1 = mean1/weight1;

            mean2 = 0;
            for i=(s+1):256
                mean2=mean2+pixelCount(i)*i;
            end
            mean2 = mean2/weight2;

            variance1 = 0;
            for i=1:s
                variance1=variance1+(i-mean1)*(i-mean1)*pixelCount(i);
            end

            variance2 = 0;
            for i=(1+s):256
                variance2=variance2+(i-mean2)*(i-mean2)*pixelCount(i);
            end

            G(s) = variance1+variance2;
        end
        [~, argmin] = min(G);
        % to come from 1:256 scale to 0:255 scale
        t = argmin-1;

    else
        fprintf("This function does not process method %s", method)
        t = 0;
        return
    end
end

for i=1:m
    for j = 1:n
        if DoubleA(i, j) > t
            B(i, j) = 255;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by OLEKSANDRA RIABOVA