% For this test, you need to copy your solution 'RGB2Grayscale.m'
% and the image 'mandril_color.png' into your working directory.

A = imread('mandril_color.png');
sz = size(A);
method = {'mean';'digicam'; 'luma'};

test = 0;
counter = 1;

%% Test datatype
for i = 1:length(method)

    try
        grIm = RGB2Grayscale(A,method{i});

        test(counter) = isa(grIm,class(A));

    catch error
        test(counter) = 0;
        fprintf('An error occured in test no. %i.\n', counter)
        disp(error)
    end
    counter = counter+1;
end

% End Test datatype
%% Test size
for i = 1:length(method)

    try
        grIm = RGB2Grayscale(A,method{i});

        test(counter) = (min(size(grIm) == sz(1:2)));

    catch error
        test(counter) = 0;
        fprintf('An error occured in test no. %i.\n', counter)
        disp(error)
    end
    counter = counter + 1;
end
% End Test size

%% Test functionality
p = [0,100,150];
p = reshape(p,1,1,3);

%% Test method mean
try
    grIm = RGB2Grayscale(p,method{1});

    test(counter) = (grIm == 83);

catch error
    test(counter) = 0;
    fprintf('An error occured in test no. %i.\n', counter)
    disp(error)
end
counter = counter + 1;
% End Test mean

%% Test method luma
try
    grIm = RGB2Grayscale(p,method{3});

    test(counter) = (grIm == 82);

catch error
    test(counter) = 0;
    fprintf('An error occured in test no. %i.\n', counter)
    disp(error)
end
counter = counter + 1;
% End Test luma

%% Test method digicam
try
    grIm = RGB2Grayscale(p,method{2});

    test(counter)= (grIm == 100);

catch error
    test(counter) = 0;
    fprintf('An error occured in test no. %i.\n', counter)
    disp(error)
end
counter = counter + 1;
% End Test digicam


disp('Summary:');
for i=1:length(test)
    if test(i)
        fprintf('Test %i: passed\n',i)
    else
        fprintf('Test %i: failed\n',i)
    end
end


% Eye Test

try

  [B] = RGB2Grayscale(A, 'mean');
  figure('Name', 'Mean')
  imshow(B)

  [B] = RGB2Grayscale(A, 'digicam');
  figure('Name', 'Digicam')
  imshow(B)

  [B] = RGB2Grayscale(A, 'luma');
  figure('Name', 'Luma')
  imshow(B)

catch error

  print('An error occured in eye test')
  disp(error)

end

