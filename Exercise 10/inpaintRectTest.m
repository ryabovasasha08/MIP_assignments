% For this test, you need to copy your solution 'inpaintRect.m' (including
% 'LPFilter.m') and the image 'mandril_defect.png' into your working directory.


A = imread('mandril_defect.png');

[M, N] = size(A);

test = 0;
counter = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 1: checks if output array has the right size + right data type (uint8)
try

  [B] = inpaintRect(A, [253,260,51,264], [38,38], 50);
  [Md, Nd] = size(B);

  test(counter) = (M == Md) && (N == Nd) && isa(B, 'uint8');

catch error

  test(counter) = 0;
  fprintf('An error occured in Test %i.\n', counter)
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter = counter + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test 2: checks if area outside rectangle R is not changed

try

  [B] = inpaintRect(A, [253,260,51,264], [38,38], 50);
  C = double(A(1:250,:)) - double(B(1:250, :));

  test(counter) = (norm(C) == 0);

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


%%%%%%%%%%%%%%%%%%%%%%%l%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eye Test: take a look at the denoised image
try

  [B] = inpaintRect(A, [253, 260, 51, 264], [38, 38], 50);

  figure('Name', 'Original image')
  imshow(A)

  figure('Name', 'Inpainted image')
  imshow(B)

catch error

  print('An error occured in Eye Test')
  disp(error)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
