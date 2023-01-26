% For this test, you need to copy your solution 'registerSkyline.m'
% and the images 'skyline_left.png', 'skyline_right_dist.png' and
% 'skyline_complete.png' into your working directory.

close all

A = imread('skyline_left.png');
B = imread('skyline_right_dist.png');

[M1, N1] = size(A);
[M2, N2] = size(B);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output array has the right size + right data type (logical)
try

  [C] = registerSkyline(A,B);
  [Mr, Nr] = size(C);

  test(counter) = (M1 == Mr) && ( (N1+N2-150) == Nr) && isa(C, 'logical');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n', counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Summary
disp('Summary:');
for i=1:length(test)
    if test(i)
        fprintf('Test %i: passed\n',i)
    else
        fprintf('Test %i: failed\n',i)
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eye Test: take a look at the denoised image
try

  [C] = registerSkyline(A,B);

  [D] = imread('skyline_complete.png');
  figure('Name', 'Original image')
  imshow(D)

  [E] = [A(:,1:(N1-150)), B];
  figure('Name', 'Deformed skyline')
  imshow(E)

  figure('Name', 'Reconstructed skyline')
  imshow(C)

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
