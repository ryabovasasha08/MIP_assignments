% For this test, you need to copy your solution 'upsampleImg.m' and the image
% 'alfred.png' into your working directory.

A = imread('alfred.png');
[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: check if upsampled matrix has the right size
try

  [B] = upsampleImg(A, 'nearestneighbor');
  [Mu, Nu] = size(B);
  test(counter) = (Mu == 2*M-1) && (Nu == 2*N-1);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: functionality test 'nearestneighbor' interpolation
try

  [B] = upsampleImg(A, 'nearestneighbor');
  test(counter) = 1 - any( any( A - B(1:2:(2*M-1),1:2:(2*N-1) ) ) );

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: functionality test 'bilinear' interpolation
try

  [B] = upsampleImg(A, 'nearestneighbor');
  test(counter) = 1 - any( any( A - B(1:2:(2*M-1),1:2:(2*N-1) ) ) );

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 4: check if pixel values are uint8
try

  [B] = upsampleImg(A, 'nearestneighbor');
  test(counter) = isa(B, 'uint8');

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
  figure
  imshow(A)
  title('original')

  [B] = upsampleImg(A, 'nearestneighbor');
  figure
  imshow(B)
  title('nearest neighbor')

  [C] = upsampleImg(A, 'bilinear');
  figure
  imshow(C)
  title('bilinear')

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
