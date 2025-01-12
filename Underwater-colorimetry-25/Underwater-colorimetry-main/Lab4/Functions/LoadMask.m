function masks = LoadMask(inImg, loadFile)

    % LoadMaskCoordinates recreates masks using saved coordinates.
    %
    % Inputs:
    %         inImg    : Input image on which the masks will be applied.
    %         loadFile : File path to load the mask coordinates 
    %                                (e.g., .mat file).
    %
    % Outputs:
    %         masks    : Struct containing recreated masks.


    % Load the saved coordinates
    loadedData = load(loadFile, 'maskCoordinates');
    maskCoordinates = loadedData.maskCoordinates;

    % Initialize the masks struct
    masks = struct();
    maskNames = fieldnames(maskCoordinates);

    % Loop through each mask and recreate the binary mask
    for i = 1:numel(maskNames)
        maskName = maskNames{i};
        pts = maskCoordinates.(maskName); % Retrieve coordinates

        % Create a binary mask using the coordinates
        mask = poly2mask(pts(:, 1), pts(:, 2), size(inImg, 1), size(inImg, 2));

        % Store in the masks struct
        masks.(maskName).mask = mask;
        masks.(maskName).pts = pts;
    end

    fprintf('Masks recreated using coordinates from %s\n', loadFile);
end
