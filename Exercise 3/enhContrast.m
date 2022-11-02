function [B] = enhContrast(A, method)
%
% enhContrast enhances the contrast of an 8-bit image A 
%
% Input:
%   A - the original image A
%   method - the method of enhancement either 'strecthing' or
%   'equalization'
%
% Output:
%   B - a contrast enhanced image of the same size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(A,1);
N = size(A,2);

B = zeros(M,N,'uint8');

if method == "stretching"
    A = double(A);
    kmax = max(max(A));
    kmin = min(min(A));
    diff = double(kmax - kmin);
    for i = 1:M
        for j = 1:N
            B(i,j) = round((double(A(i,j)) - kmin) / diff * 255);
        end
    end
else                                                %method == "equalization"
    H = imhist(A);
    totalpixels = M * N;              
    scale_factor = double(255 / totalpixels);       %normalization factor
    
    sum = zeros(256,1);
    sum(1) = H(1);                                  %sum up frequencies cumulatively
    for i = 2:size(sum)
        sum(i) = sum(i-1) + H(i);
    end
    
    phi = zeros(256,1);
    for i = 1:size(phi)                             %normalize the sum
        phi(i) = round(sum(i) * scale_factor);
    end
    
    for i = 1:M                                     %enhance original image with map phi
        for j = 1:N
            B(i,j) = phi(double(A(i,j))+1);
        end
    end
end


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by Oleksandra Riabova, Yasmeen Hack, Shriya Jain


