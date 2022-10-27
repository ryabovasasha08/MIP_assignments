% For this test, you need to copy your solution 'enhContrast.m' and the image
% 'alfred_lowcontrast.png' into your working directory. Additionally, you need
% to install and load the 'image' package/toolbox.


A = imread('alfred_lowcontrast.png');
[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output image has the right size
try

  [B] = enhContrast(A, 'stretching');
  [C] = enhContrast(A, 'equalization');
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

  [B] = enhContrast(A, 'stretching');
  [C] = enhContrast(A, 'equalization');

  test(counter) = isa(B, 'uint8') && isa(C, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: functionality test method 'stretching'
try

  [B] = enhContrast(A, 'stretching');
  kmin = min(min(B));
  kmax = max(max(B));

  test(counter) = (kmin == 0) && (kmax == 255);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 4: functionality test method 'equalization'
try

  [B] = enhContrast(A, 'equalization');
  kmax = max(max(B));
  kmin = min(min(B));

  test(counter) = (kmin <= 1) && (kmax == 255);

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

  [B] = enhContrast(A, 'stretching');

  figure
  imshow(B)
  title('Output method stretching')

  figure
  bar(0:255, imhist(B))
  xlim([0, 255])
  title('Histogram after stretching')

  [B] = enhContrast(A, 'equalization');

  figure
  imshow(B)
  title('Output method equalization')

  figure
  bar(0:255, imhist(B))
  xlim([0, 255])
  title('Histogram after equalization')


catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
