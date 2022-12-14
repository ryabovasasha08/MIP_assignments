% For this test, you need to copy your solution 'laplaceSharpening.m' and the
% image 'moon.png' into your working directory.


A = imread('moon.png');

[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output array has the right size + right data type (uint8)
try

  [B] = laplaceSharpening(A, 0.1, 10);
  [Md, Nd] = size(B);

  test(counter) = (M == Md) && (N == Nd) && isa(B, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
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

  [B] = laplaceSharpening(A, 0.16, 5);

  figure('Name', 'Original image')
  imshow(A)

  figure('Name', 'Sharpened image')
  imshow(B)

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
