function [B] = RGB2Grayscale(A, method)
%
% RGB2Grayscale converts an 8bit image to grayscale using a specified
% method
%
% Input
%   A: original image
%   method: string specifying name of the conversion method to use
%
% Output:
%   B: 8 bit grayscale image the same size as A
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%A = double(A);
M = size(A,1);
N = size(A,2);
B = zeros(M,N,'uint8');

if method == "digicam"
    B = uint8(A(:,:,2));

elseif method == "mean"
    for i = 1:M
        for j = 1:N
            B(i,j) = 1/3 * (double(A(i,j,1)) + double(A(i,j,2)) + double(A(i,j,3)));
        end
    end

else
    for i = 1:M
        for j = 1:N
            B(i,j) = 0.2126*double(A(i,j,1)) + 0.7152*double(A(i,j,2))...
                + 0.0722*double(A(i,j,3));
        end
    end

end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by Yasmeen Mai Hack
