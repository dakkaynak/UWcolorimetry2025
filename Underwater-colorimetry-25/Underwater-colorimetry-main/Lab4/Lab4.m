% January 12, 2025
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 4                                %%%
%%%               Underwater Image Formation Exercises                 %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  LAB 4:  
%        Exercise 1: Simulating DGK color chart underwater.
%        Exercise 2: Optical comparison of different water types (Jerlov).
%        Exercise 3: Directional underwater image formation.








%% Load the required data.

clear all; close all; clc; 


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




%% Exercise 1: Simulating DGK color chart underwater

% Scaling parameters
RGB_scale = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, 0, c, 0, b, Cannon_Sc.data(:,2:end));
white_scaling_value = RGB_scale(3,:);


% Set specific water type: 1 is the clearest, 8 is the most turbid.
Water_Type = 1;


% Spectral attenuation coefficients for the choosen water type.
% b is scattring coefficient
% c is the beam attenuation coeficient
% Kd is the diffuse downwelling attenuation coefficient
Kd = Jerlov_Kd(:,Water_Type);
c = Jerlov_c(:,Water_Type);
b = Jerlov_b(:,Water_Type);


% Vertical depth D: color chart below the sea surface
Depth = 5;

% Viewing distance z: distance between the observer and color chart
Distance = 2;


% Simulating RGB values given water type and viewing geometry
RGB = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, Depth, c, Distance, b, Cannon_Sc.data(:,2:end));

% Scaling the simulated RGB values
Ic = RGB./white_scaling_value;

% Displying the image
mcc = visualizeDGK(mat2gray(Ic));
imshow(2*mcc)



%% Exercise 2: Comparing the 8 different Jerlov water types
% Initialize an image array to store the 8 images
% Use a cell array for storing the images
CC_array = cell(1, 8); 

for i = 1:8
    Water_Type = i;

    % Extract water type parameters
    Kd = Jerlov_Kd(:, Water_Type);
    c = Jerlov_c(:, Water_Type);
    b = Jerlov_b(:, Water_Type);

    % Set depth and distance parameters
    CompDepth = 5;
    CompDistance = 2;

    % Compute the underwater radiance
    RGB = get_UW_radiance(Refl_spectra_DGK.data(:, 2:end)', light_spectra_D65, Kd, CompDepth, c, CompDistance, b, Cannon_Sc.data(:, 2:end));

    % Normalize the radiance values
    Ic = RGB ./ white_scaling_value;

    % Visualize and store the resulting image in the array
    CC_array{i} = visualizeDGK(mat2gray(Ic)); % Store the image in the cell array
end

% Convert the cell array to a 4D array for montage
CC_montage = cat(4, CC_array{:});

% Display the 8 images in 2 rows and 4 columns using montage
figure;
montage(CC_montage, 'Size', [2 4]); % Specify 2 rows and 4 columns
title('Optical comparsion of 8 water types from Jerlovs data-set');






%% Exercise 3: Directional underwater image formation









