function out = getlincam(ref,RGB)
%
% OUT = GETLINCAM(REF,RGB)
% 
% REF     : Luminance (Y) values of neutral patches of calibration target.
% RGB     : RGB values in 3 x N format, that correspond to the neutral
% patches of the calibration target
% OUT     : Values used to linearize camera RGB values.
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


RGB = double(RGB);

[pr1,~] = polyfit(RGB(1,:),ref,3);
[pg1,~] = polyfit(RGB(2,:),ref,3);
[pb1,~] = polyfit(RGB(3,:),ref,3);

out = [pr1;pg1;pb1];



