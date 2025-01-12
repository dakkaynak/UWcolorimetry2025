function Kd_c = KdPlusc(BetaC,m,Kw,cw, Lambda_0)

% KdPlusc() estimates spectral (Kd + c) from single wavelngth value
%
% Inputs:
%         BetaC     :  Measured value of [Kd + c] at a single wavelength.
%         m         :  Numericaly derived by Austin and Petzold (1984).
%         Kw        :  Diffuse downwelling attenuation coefficient 
%                      of pure sea water.
%         cw        :  Beam attenuation coefficient of pure sea water.
%         Lambda_0  :  Wavelength of measurement.
%
%
% Outputs:
%          Kd_c     :  Spectral estimation of [Kd + c].


Kd_c = m*abs(BetaC - Kw(Lambda_0) - cw(Lambda_0)) + Kw + cw;


end