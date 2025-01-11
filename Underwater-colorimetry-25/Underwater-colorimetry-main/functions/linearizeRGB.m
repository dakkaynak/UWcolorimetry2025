function outImg = linearizeRGB(p,inImg)
%
% OUTIMG = linearizeRGB(P,INIMG)
% 
% P       : Values to be used in linearization
% INIMG     : RGB values in 3 x N format, that correspond to the neutral
% patches of the calibration target
% OUTIMG  : Linearized version of inImg.
%
% This script was modified from the book:
%
% "Computational Colour Science Using MATLAB", Westland & Ripamonti 2004.
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

s = size(inImg);
RGB = reshape(inImg,prod(s)/3,3);
for i = 1:3
    x  = polyval(p(i,:),RGB(:,i));
    RGB(:,i) = x;
end
outImg = reshape(RGB,s);
outImg(outImg<0)=0;
outImg(outImg>1)=1;

