function [B] = rotateImg(A, phi, method)
%
% rotateImg rotates an image by a specified angle
% Input:
%   A - the original image
%   method - the interpolation method to be used, either nearest neighbor
%   or bilinear
%   phi - the angle of rotation
%
% Output:
%   B - a new rotated image of the same size as the original
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = size(A, 1);
n = size(A, 2);
B = uint8(ones(m, n));
ci = m/2;
cj = n/2;
rotate_matrix = [cos(phi) -sin(phi); sin(phi) cos(phi)];
for i=1:m
    for j=1:n
        x = i -ci;
        y = j - cj;
        initial_coords_double = rotate_matrix\[x; y]+[ci; cj];
        initial_coords = initial_coords_double;
        if initial_coords(1)>0 && initial_coords(1)<m && initial_coords(2)>0 && initial_coords(2)<n
            if method == "nearestneighbor"
                initial_coords = [round(initial_coords_double(1)) round(initial_coords_double(2))];
            else
                initial_coords = [round(initial_coords_double(1)) round(initial_coords_double(2))];
            end
            B(i, j) = A(initial_coords(1), initial_coords(2));
        end
    end
end

%by OLEKSANDRA RIABOVA; SHRIYA JAIN; YASMEEN MAI HACK