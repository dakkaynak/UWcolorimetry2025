
dngPath = ['yourpath...\dng']; %change to your path 
tiffSavePath = ['yourpath...\tiff'];%change to your path
CompresedPngPath = ['yourpath...\Cpng'];
stage = 4;
cd('yourpath...\Underwater-colorimetry-main\camera-pipeline-nonUI-master')%change to your path
dng2tiff(dngPath, TiffPath, stage);
tiff2png(CompresedPngPath, tiffSavePath)
