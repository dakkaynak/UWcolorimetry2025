function radiance = getradiance(reflectance, light, observer)

% This function calculates radiance from given reflectance, light, and
% observer spectra.

% The inputs should have the following dimensions:
% Reflectance: M x N, where M is the number of different reflectances, and N is the number
% of wavelength steps. M is 24 for a MacbethColorChecker

% light: 1 x N, where N is the number of wavelength steps
% Observer spectra, 3 x N, where N is the number of wavelength steps.

% The output radiance is M x 3.

s = size(reflectance);

radiance = (reflectance .* repmat(light,[s(1) 1])) * observer;