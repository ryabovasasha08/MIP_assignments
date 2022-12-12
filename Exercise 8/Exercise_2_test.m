A = imread('test_img.png');

[M, N] = size(A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output array has the right size + right data type (uint8)
try

  [B] = detectEdges(A, [0.5, 0.7], 3);
  [Md, Nd] = size(B);
  test = (M == Md) && (N == Nd) && isa(B, 'uint8');

catch error

  test = 0;
  fprintf('An error occured in Test')
  disp(error)

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eye Test: take a look at the denoised image
try

  figure('Name', 'Original image:')
  imshow(A)

  [B] = detectEdges(A, [0.5, 0.7], 3);

  figure('Name', 't = [0.5, 0.7], sigma = 3')
  imshow(B)

  [B] = detectEdges(A, [0.5, 0.7], 7);

  figure('Name', 't = [0.5, 0.7], sigma = 7')
  imshow(B)

  [B] = detectEdges(A, [2, 5], 7);

  figure('Name', 't = [2, 5], sigma = 7')
  imshow(B)

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
