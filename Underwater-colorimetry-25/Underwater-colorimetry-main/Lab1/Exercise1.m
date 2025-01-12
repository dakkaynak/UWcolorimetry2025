% June 8, 2023
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 1                                %%%
%%%      RAW Image Manipulation Exercises and Basic Image Formation    %%%


%%%                             Exercise 1                             %%%
%%%                    Image Manipulatoin Exercises                    %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Part I: Converting RAW images
%   Instructions:
%   Change all "yourpath..." to the appropriate path on your computer


dngPath = 'yourpath...\dng';  
tiffSavePath = 'yourpath...\tiff';
CompresedPngPath = 'yourpath...\Cpng';
stage = 4;

cd('yourpath...\Underwater-colorimetry-main\camera-pipeline-nonUI-master')
dng2tiff(dngPath, tiffSavePath, stage);
tiff2png(CompresedPngPath, tiffSavePath);


%% Part II: Show linear and non-linear image side by side
%   Instructions:
%   Change non_linear_image.dng to a .dng image from your dataset.
%   Change linear_image.tif to a .tif image from your dataset.

I_linear = imread('non_linear_image.tif');
I_Not_linear = imread('non_linear_image.dng');

B = 2;

montage({B*I_Not_linear, B*I_linear})

% You should see your linear and not linear images side by side.
% You can change brightness by changing the scalar B 

