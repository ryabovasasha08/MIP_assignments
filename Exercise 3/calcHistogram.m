function [H] = calcHistogram(A)
%
% calcHistogram calculates the histogram of an 8-bit grayscale image
%
%   Input:
%       A - the original image
%
%   Output: 
%       H - the histogram of the image as a vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(A,1);
N = size(A,2);
H = zeros(256,1);
value = 0;

for i = 1:M
    for j = 1:N
        value = A(i,j);
        H(value+1) = H(value+1) + 1;  
    end
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by Oleksandra Riabova, Yasmeen Hack, Shriya Jain


