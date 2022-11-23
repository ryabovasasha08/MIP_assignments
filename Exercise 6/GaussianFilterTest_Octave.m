% For this test, you need to copy your solution 'GaussianFilter.m' and the
% images 'mandril_pnoise.png', 'plain_pnoise.png' into your working directory.
% Furthermore, you need to install / load the image package / toolbox.


A = imread('mandril_gray.png');

[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output array has the right size + right data type (uint8)
try

  [B, F] = GaussianFilter(A, 0.5);
  [Md, Nd] = size(B);

  test(counter) = (M == Md) && (N == Nd) && isa(B, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: checks for correct size of filter mask
try

  [B, F] = GaussianFilter(A, 2);
  [MF, NF] = size(F);

  test(counter) = (MF == 13) && (NF == 13);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: checks for correct output
try

  [B, F] = GaussianFilter(A, 2);
  [C] = imsmooth(A, 'gaussian', 1.5);

  test(counter) = ( norm( im2double(C) - im2double(B) ) < 1.15 );

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

  [B, F] = GaussianFilter(A, 0.5);

  figure
  imshow(B)
  title('t = 0.5')

  [B, F] = GaussianFilter(A, 5);

  figure
  imshow(B)
  title('t = 5')

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
