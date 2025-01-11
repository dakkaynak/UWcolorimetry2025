% dng2tiff reads dng file into matlab as linear RGB.

% Status = raw2dng(rawPath) takes as input a dng image, performs steps 1-4
% of the pipeline from Karaimer & Brown code, and saves a tiff image.
%
% Modified from the toolbox released by Karaimer & Brown:
%
% Karaimer, Hakki Can, and Michael S. Brown. ECCV 2016
% "A software platform for manipulating the camera imaging pipeline."
%
% The mac version of dng_validate was written by Ben Singer from Princeton.
%
% Derya Akkaynak 2019 | deryaa@alum.mit.edu
function [I,shortName,outputFilePath] = dng2tiff(dngPath, tiffSavePath,stage)
if nargin < 3
    stage = 4;
end
saveFolder = fullfile('.','dngOneExeSDK');
writeTextFile(saveFolder,'wbAndGainSettings',[1 0 0 0]);%[1 0 0 0]
writeTextFile(saveFolder,'rwSettings',0);
writeTextFile(saveFolder,'stageSettings',stage);
writeTextFile(saveFolder,'cam_settings',0);
writeTextFile(saveFolder,'lastStage',stage);

% pathParts = strsplit(dngPath,filesep);
% fileName = pathParts{end};
% shortName = fileName(1:end-4);
% outputFilePath = fullfile(tiffSavePath,[shortName,'.tif']);
%
%status = system([fullfile('.','dngOneExeSDK','dng_validate.exe -16 -cs1 -tif ') ,  outputFilePath ' ' dngPath]);
dngFiles = dir(fullfile(dngPath, '*.dng'));

for k=1:length(dngFiles)
    thisFile = dngFiles(k).name;
%     pathParts = strsplit(dngPath,filesep);
%     fileName = pathParts{end};
    shortName = thisFile(1:end-4);
    outputFilePath = fullfile(tiffSavePath,[shortName,'.tif']);
    dngFile = dngFiles(k).name
    status = system(join([fullfile('.','dngOneExeSDK','dng_validate.exe -16 -3 ')  outputFilePath ' ' [dngPath,'\', dngFile]]));

    if status~=0
        fprintf(2,['dng2tiff: There was a problem processing the DNG image ',dngPath,'\n']);
        I = [];
    else
        % outputs from the Karaimer & Brown code are uint16. Scale to be in
        % [0,1];
        I = double(imread(outputFilePath))./2^16;
    end
    
end