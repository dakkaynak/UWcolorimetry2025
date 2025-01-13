% June 8, 2023 modified January 22, 2024
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 4                                %%%
%%%               Underwater Image Formation Exercises                 %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  LAB 4:  
%           Exercise 1: Quantitative color comparison 
%           Exercise 2: RGB to XYZ transformation
%           Exercise 3: xy white point coordinates
%           Exercise 4: XYZ to Standard RGB transformation


clear all; close all; clc; 




%% LOad the required data.

% Wavelength range: 400-700[nm]
WL = 400:10:700;


% Loading reflectences of DGK color chart
load('Data/DGKColorChart.mat')
Refl_spectra_DGK = importdata('Data/DGKcolorchart_reflectances.csv');


% Loading the scattering coefficient b
Jerlov_b = importdata('Data/Jerlov_b.csv');
% Loading the diffuse downwelling attenuation coefficient Kd
Jerlov_Kd = importdata('Data/Jerlov_Kd.csv');
% Loading the beam attenuation coefficient c
Jerlov_c = importdata('Data/Jerlov_c.csv');


% Loading camera sensitivities
Cannon_Sc = importdata('Data/Canon_1Ds-Mk-II.csv');


% Loading light spectrum
light_D65 = importdata('Data/illuminant-D65.csv');
% Interpolate data to wavelength range  
light_spectra_D65 = interp1(light_D65.data(:,1),light_D65.data(:,2),WL);


Kd = Jerlov_Kd(:,3);
c = Jerlov_c(:,3);
b = Jerlov_b(:,3);

Depth = 1;
Distance = 10;

RGB = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, Depth, c, Distance, b, Cannon_Sc.data(:,2:end));

mcc = visualizeDGK(mat2gray(RGB));
imshow(2*mcc)
