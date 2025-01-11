function ppRGB = XYZ2ProPhoto(inImg)
%
% PPRGB = XYZ2PROPHOTO(INIMG)
% 
% INIMG     : input RGB image of size NxMx3, linear RGB.
% PPRGB     : output RGB image of size NxMx3, in ProPhoto RGB space.
% Transformation taken from http://brucelindbloom.com. To get to the relevant page, click Math, click
% RGB/XYZ matrices.
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
% The MIT License (MIT)
% 
% Copyright (c) <2013> <Derya Akkaynak>
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
% ************************************************************************

% Under D50
s = size(inImg);

% Prophoto matrix
M = [1.3459 -0.2556 -0.0511;...
    -0.5446 1.5082 0.0205;...;
    0 0 1.2118];

% Wide gamut RGB
M = [1.4628067 -0.1840623 -0.2743606;
-0.5217933  1.4472381  0.0677227;
 0.0349342 -0.0968930  1.2884099;
];

RGB = M*reshape(xyz2double(inImg),[s(1)*s(2) 3])';
RGB(RGB<=0)=0;
%RGB(RGB>1)=1;


ppRGB = reshape(RGB',[s(1) s(2) 3]);

