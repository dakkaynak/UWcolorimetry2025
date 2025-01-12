function WriteImgData(SavePath, FileName, ImageFolder, Chart, SD, NeutralPatches, MaskDim, z)

    % WriteAverageRGB writes the average RGB values of each mask to a .csv file.
    %
    % Inputs:
    %        SavePath       : Path to save the output .csv file.
    %        FileName       : Name of the output .csv file (without extension).
    %        ImageFolder    : Folder containing the image files.
    %        Chart          : DGKColorChart structure.
    %        SD             : Cell array of color names 
    %                         (e.g., {'white', 'black', 'gray1'}).
    %        NeutralPatches : Coordinates of the neutral patches.
    %        MaskDim        : Mask size parameter for makeChartMask function.

    

    % Get all image files in the folder
    files = dir(fullfile(ImageFolder, '*.png')); % Adjust extension if needed
    ImageFiles = fullfile({files.folder}, {files.name}); % Cell array of full paths

    % Initialize a cell array to store data
    WriteImgData = {}; % This will store file name, mask name, and average RGB values

    % Loop through all image files
    for i = 1:length(ImageFiles)
        % Read and preprocess the image
        I = im2double(imread(ImageFiles{i}));
        imshow(I)
        % Generate masks using the provided chart and color names
        masks = makeChartMask(I, Chart, SD, MaskDim);
        
        % Get average RGB values for each patch
        RGBValues = getPatchValues(I, masks, NeutralPatches, SD);
        
        % Append the file name, mask name, and average RGB values to the data
        for j = 1:length(SD)
            WriteImgData = [WriteImgData; {files(i).name, SD{j}, ...
                RGBValues(j, 1), RGBValues(j, 2), RGBValues(j, 3)}, z];
        end
    end

    % Write data to a .csv file
    csvFileName = fullfile(SavePath, [FileName, '.csv']);
    header = {'FileName', 'MaskName', 'R', 'G', 'B', 'z'}; % Define column headers
    RGBTable = cell2table(WriteImgData, 'VariableNames', header);
    writetable(RGBTable, csvFileName);

    % Display completion message
    fprintf('Average RGB values have been written to %s\n', csvFileName);
end
