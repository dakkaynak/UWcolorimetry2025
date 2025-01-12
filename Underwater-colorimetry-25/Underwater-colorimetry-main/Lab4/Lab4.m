% Provide the full file name including extension
SavePath = 'C:\Users\colorlab\Desktop\MSc\Research\Data';
FileName = 'EilatJanSD-2m.csv';

% Read the data
imageData = ReadImgData(SavePath, FileName);

% Display the data
% disp(imageData);

folder = 'C:\users\colorlab\Desktop\Underwater-colorimetry-main\End-game-SD-26.09.24\11m\dng';
files = dir(fullfile(folder,'*.dng'));
saveImageData(folder, files, fullfile(folder, 'MetaData.txt'))

