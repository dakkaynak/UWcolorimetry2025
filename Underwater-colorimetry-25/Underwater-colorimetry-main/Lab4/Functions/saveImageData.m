function saveImageData(mainfolder,files,savePath)

% saveImageData writes the metadata of images in mainfolder
%
% Inputs:
%        mainfolder  :  Folder containing the desired images
%        files       :  Specify the exact format (e.g. .jpg, .gnd etc..)
%        savepath    :  Saving path of the ouput .txt file
%
%
% Output:
%        .txt file with the matadata following:
%        FileName | Shutter | Apperture | ISO
          
fid = fopen(savePath,'w+');

for i = 1:numel(files)
    info = imfinfo(fullfile(mainfolder,files(i).name));
    exposure = info(1).DigitalCamera.ExposureTime;
    f = info(1).DigitalCamera.FNumber;
    iso = info(1).DigitalCamera.ISOSpeedRatings;
    fprintf(fid,[files(i).name,'\t',num2str(exposure),'\t',num2str(f),'\t',num2str(iso),'\n']);
end

fclose(fid);