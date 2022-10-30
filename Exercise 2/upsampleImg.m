function [B] = upsampleImg(A, method)
%
% UpsampleImg converts an image to a higher resolution one
% Input:
%   A - the original image
%   method - interpolation method, either nearest neighbor or bilinear
%
% Output:
%   B - the new upsampled image
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    m = size(A, 1);
    n = size(A, 2);
    B = uint8(zeros(m*2-1, n*2-1));
    ratio = 0.5;
    if method == "nearestneighbor"
        for j  = 1:(2*n-1)
            for i  = 1:(2*m-1)
                B(i, j) = A(ceil(i*ratio), ceil(j*ratio));
            end
        end   
    else
        B(1:2:end, 1:2:end) = A;
        for j  = 2:2:(2*n-2)
            for i  = 1:(2*m-1)
                B(i, j) = ratio*(B(i,j+1) + B(i, j-1));
            end
        end 
        for j  = 1:(2*n-1)
            for i  = 2:2:(2*m-2)
                B(i, j) = ratio*(B(i+1,j) + B(i-1, j));
            end
        end 

    end
end

%by OLEKSANDRA_RIABOVA, SHRIYA JAIN, YASMEEN MAI HACK