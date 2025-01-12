function [rawRGB, scaledRGB, z] = FinalRGB(Data, Patch)

% FinalRGB() function returns scaled and raw RGB's and distance z
%
% Inputs:
%        Data       : Struct with Data.data and Data.textdata 
%    'FileName'	'MaskName'	'R'	'G'	'B'	'z'	'shutter '	'apperture'	'iso'
%
%        Patch      : n x 1 cell with patch per color and one for
%                     background.
%                     For example: Secchi Disk Patch is: 
%                         {'white', 'black', 'gray1'}
%
%
% Outputs:
%         rawRGB    :  Original RGB's
%         scaledRGB :  Scaled RGB with respect to ISO and shutter speed
%         Z         :  Distance


ind = find(contains(Data.textdata(:,2), Patch)) - 1;

rawRGB = Data.data(ind,:);

scaledRGB = ScaleRGB(rawRGB);

z = Data.data(ind,4);

rawRGB = rawRGB(:, 1:3);

end