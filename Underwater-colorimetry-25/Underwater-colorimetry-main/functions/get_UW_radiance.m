function [Ic, Dc, Bc] = get_UW_radiance(reflectance, light, Kd, D, c, z, b, observer)

% This function calculates radiance from given reflectance, light, and
% observer spectra.

% The inputs should have the following dimensions:
% Reflectance: M x N, where M is the number of different reflectances, 
% and N is the number of wavelength steps. 

% M is 24 for a MacbethColorChecker and 18 for DGK

% light: 1 x N, where N is the number of wavelength steps
% Observer spectra, 3 x N, where N is the number of wavelength steps.

% The output radiance is M x 3.

s = size(reflectance);

Dc = (reflectance .* repmat(light,[s(1) 1]))*diag(exp(-Kd*D))*diag(exp(-c*z))*observer;
Bc = ((b./c)').*(light.*exp(-Kd*D)').*(1 - exp(-c*z)')*observer;

% Bc_scaled = Bc./Dc(1,:);
% UW_radiance = (reflectance .* repmat(light,[s(1) 1])) * observer;
Ic = Dc + Bc;