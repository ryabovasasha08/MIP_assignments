% For this test, you need to copy your solution 'bwConversion.m' and the image
% 'noisy_fingerprint.png' into your working directory.


A = imread('noisy_fingerprint.png');
[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output image has the right size
try

  [B] = bwConversion(A, 'median');
  [C] = bwConversion(A, 'otsu');
  [M1, N1] = size(B);
  [M2, N2] = size(C);

  test(counter) = (M1 == M) && (N1 == N) && (M2 == M) && (N1 == N);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: checks if output image is 'uint8'
try

  [B] = bwConversion(A, 'median');
  [C] = bwConversion(A, 'otsu');

  test(counter) = isa(B, 'uint8') && isa(C, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: functionality test method 'median'
try

  [B, t] = bwConversion(A, 'median');
  diff = B - (A > t)*255;

  test(counter) = (t == 179) && ( length( find(diff) ) == 0 );

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 4: functionality test method 'otsu'
try

  [B, t] = bwConversion(A, 'otsu');
  diff = B - (A > t)*255;

  test(counter) = (t == 125) && ( length( find(diff) ) == 0 );

  % Note: kmin does not always have to be 0 after histogram equalization!

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
% Eye test: take a look at the result
try

  [B] = bwConversion(A, 'median');

  figure
  imshow(B)
  title('Output image median')

  [B] = bwConversion(A, 'otsu');

  figure
  imshow(B)
  title('Output image otsu')



catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
