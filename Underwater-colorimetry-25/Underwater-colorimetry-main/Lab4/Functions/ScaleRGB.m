function ScaledRGB = ScaleRGB(RGBrawData)

% Inputs:
%          RGBrawData :   (R, G, B, z, shutter, apperture, ISO)
%
%
% Output:
%          ScaledRGB  



RGB = RGBrawData(:,1:3);
% z = RGBrawData(:,4);
shutter = RGBrawData(:,5);
ISO = RGBrawData(:,7);

SetISO = 550; 

% Scale for ISO
stdISO_RGB = repmat(SetISO./ISO, [1,3]).*RGB;

% Scale for shutter
ScaledRGB = stdISO_RGB./repmat(shutter, [1,3]);

end