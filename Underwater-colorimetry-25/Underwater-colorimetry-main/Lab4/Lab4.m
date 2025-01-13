% June 8, 2023 modified January 22, 2024
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 4                                %%%
%%%               Underwater Image Formation Exercises                 %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  LAB 4:  
%           Exercise 1: 
%           Exercise 2: 
%           Exercise 3: 
%           Exercise 4: 


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


% Scaling
RGB_scale = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, 0, c, 0, b, Cannon_Sc.data(:,2:end));
white_scaling_value = RGB_scale(3,:);


% Simulating DGK color chart
Water_Type = 7;
Kd = Jerlov_Kd(:,Water_Type);
c = Jerlov_c(:,Water_Type);
b = Jerlov_b(:,Water_Type);

Depth = 2;
Distance = 0.8;

RGB = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, Depth, c, Distance, b, Cannon_Sc.data(:,2:end));
Ic = RGB./white_scaling_value;
mcc = visualizeDGK(mat2gray(Ic));
imshow(2*mcc)
