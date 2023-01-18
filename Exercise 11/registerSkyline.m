function [C] = registerSkyline(A, B)
%
% Input:
%   A: left side of the image
%   B: deformed right side of the image
%
% Output:
%   C: full image of the skyline, concatenated
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%determine a,b,c for transformation phi

Ap = [36,6,1;128*128,128,1;139*139,139,1];
q = [95,14,10]';

coeff = Ap\q;

[M,N] = size(B);
u_R = zeros(size(B));

for i = 1:M
    for j = 1:N
        phi1 = round(i);
        phi2 = round(coeff(1)*i^2 + coeff(2)*i + coeff(3) + j);
        if phi2 < 1 || phi2 > N
            u_R(i,j) = 0;
        else
            u_R(i,j) = B(phi1,phi2);
        end
    end
end
imshow(u_R)

%join the two images

C = logical(uint8(horzcat(A,u_R(:,151:end))));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%by Yasmeen Mai Hack
