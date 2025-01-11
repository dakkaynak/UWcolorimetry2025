function Iwb = whiteBalance(inImg,maskWS,maskDS,f)
%
% IWB = WHITEBALANCE(INIMG,MASKWS,MASKDS,F)
% 
% INIMG     : RGB image of size NxMx3
% MASKWS     : mask for the white standard, WS
% MASKDS     : mask for the dark standard, DS
% F     : Relative brightness of the WS. f = 1 may saturate most images, so
% default value is 0.8.
% IWB     : white balanced image, size NxMx3
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


assert(numel(size(inImg))==3,'The image must be an RGB image.');

if nargin<4
    f = 0.8;
end

WS = getPatchMean(inImg,maskWS);
DS = getPatchMean(inImg,maskDS);

Rlayer = double(inImg(:,:,1));
Glayer = double(inImg(:,:,2));
Blayer = double(inImg(:,:,3));

Rlayer = f*(Rlayer - DS(1))./(WS(1) - DS(1));
Glayer = f*(Glayer - DS(2))./(WS(2) - DS(2));
Blayer = f*(Blayer - DS(3))./(WS(3) - DS(3));

Rlayer(Rlayer>1)=1;
Glayer(Glayer>1)=1;
Blayer(Blayer>1)=1;

Iwb(:,:,1) = Rlayer;
Iwb(:,:,2) = Glayer;
Iwb(:,:,3) = Blayer;