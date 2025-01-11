function tiff2png(pngPath,tiffPath)

files = dir(fullfile(tiffPath,'*.tif'));

for i = 1:numel(files)
    I = imread(fullfile(tiffPath,files(i).name));
    imwrite(imresize(I,0.3),fullfile(pngPath,[files(i).name(1:end-4),'.png']))
end