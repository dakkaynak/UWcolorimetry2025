function vals = getPatchValues(I,masks,locs,colors)
%
% VALS = GETPATCHVALUES(I,MASKS,LOCS,COLORS)
% 
% I         : input RGB image of size NxMx3.
% MASKS     : struct that contains a mask for each color patch. 
%           masks.(color).pts has the xy coordinates of the masks, and
%           masks.(color),mask has a binary mask.
% LOCS      : row and column position(s) of patches of interest
% COLORS    : cell array containing the names, or numbers of color patches
% in the chart being used. see macbethColorChecker.m for the format.
% VALS      : RGB values extracted from patches, dimensions 3 x size(locs,1)
%
% ************************************************************************
% If you use this code, please cite the following paper:
%
%
% <paper>
%
% ************************************************************************
% For questions, comments and bug reports, please use the interface at
% Matlab Central/ File Exchange. See paper above for details.
% ************************************************************************

numMasks = size(locs,1);
vals = zeros(3,numMasks);
for i  = 1:numMasks   
    vals(:,i) = getPatchMean(I,masks.(colors{locs(i,1),locs(i,2)}).mask);
end

