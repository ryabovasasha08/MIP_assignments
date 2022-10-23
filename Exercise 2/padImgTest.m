% For this test, you need to copy your solution 'padImg.m' and the image
% 'alfred.png' into your working directory.

A = imread('alfred.png');
[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: test if padding number p is sufficiently high
try

  [Ap, p] = padImg(A);
  test(counter) = (p >= 205);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: check if padded image has the right size
try

  [Ap, p] = padImg(A);
  [Mp, Np] = size(Ap);
  test(counter) = ((M+2*p) == Mp) && ((N+2*p) == Np);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: check if values outside original image are 0
try

  [Ap, p] = padImg(A);
  test(counter) = 1 - ( any( any(  Ap( [1:p,(M+p+1):(M+2*p)],: ) ) )...
  && any( any( Ap(:,[1:p,(N+p+1):(N+2*p)]) ) ) );

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 4: check if original image is in the center of the padded version
try

  [Ap, p] = padImg(A);
  test(counter) = 1 - any(any( A - Ap((p+1):(M+p),(p+1):(N+p))));

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 5: check if pixel values are uint8
try

  [Ap, p] = padImg(A);
  test(counter) = isa(Ap, 'uint8');

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

  [Ap, p] = padImg(A);
  figure
  imshow(Ap)

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
