% For this test, you need to copy your solution 'rotateImg.m' and the image
% 'alfred_padded.png' into your working directory. Additionally, you need to
% install and load the 'image' package/toolbox.


A = imread('alfred_padded.png');
[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if image size remains the same
try

  [B] = rotateImg(A, pi/4, 'nearestneighbor');
  [Mr, Nr] = size(B);
  test(counter) = (Mr == M) && (Nr == N);

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: check if pixel values are uint8
try

  [B] = rotateImg(A, pi/4, 'nearestneighbor');
  test(counter) = isa(B, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 3: functionality check 'nearestneighbor' method, comparison w\ imrotate
try

  [B] = rotateImg(A, pi/4, 'nearestneighbor');
  [C] = imrotate(A, 45, 'nearest', 'crop');

  test(counter) = norm(im2double(B - C), 'inf') < 5;

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n',counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 4: functionality check 'bilinear' method, comparison w\ imrotate
try

  [B] = rotateImg(A, pi/4, 'bilinear');
  [C] = imrotate(A, 45, 'linear', 'crop');

  test(counter) = norm(im2double(B - C), 'inf') < 5;

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

  angle = [pi/2, pi/4];

  for i=1:length(angle)

    [B] = rotateImg(A, angle(i), 'nearestneighbor');
    figure
    imshow(B)
    title(['nearest neighbor interpolation with angle ' num2str(angle(i))])

  end

  for i=1:length(angle)

    [B] = rotateImg(A, angle(i), 'bilinear');
    figure
    imshow(B)
    title(['bilinear interpolation with angle ' num2str(angle(i))])

  end

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
