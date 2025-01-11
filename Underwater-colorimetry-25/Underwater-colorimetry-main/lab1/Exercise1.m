% June 8, 2023
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 1                                %%%
%%%     Basic Image Formation and RAW Image Manipulation Exercises     %%%


%%%                             Exercise 1                             %%%
%%%                    Image Manipulatoin Exercises                    %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%   Instructions:
%   Change all "yourpath..." to the appropriate path on your computer


dngPath = 'yourpath...\dng';  
tiffSavePath = 'yourpath...\tiff';
CompresedPngPath = 'yourpath...\Cpng';
stage = 4;

cd('yourpath...\Underwater-colorimetry-main\camera-pipeline-nonUI-master')
dng2tiff(dngPath, tiffSavePath, stage);
tiff2png(CompresedPngPath, tiffSavePath);
