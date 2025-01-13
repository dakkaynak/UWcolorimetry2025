% January 12, 2025
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 4                                %%%
%%%               Underwater Image Formation Exercises                 %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  LAB 4:  
%        Exercise 1: Simulating DGK color chart underwater.
%        Exercise 2: Direct signal (Dc) and Backscatter (Bc).
%        Exercise 3: Optical comparison of different water types (Jerlov).
%        Exercise 4: RGB's (Ic) as function of viewing distance (z).








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

% Set specific water type: 1 is the clearest, 8 is the most turbid.
Water_Type = 3;
% Vertical depth D: color chart depth below the sea surface
Depth = 5;
% Viewing distance z: distance between the observer and color chart
Distance = 10;



% Spectral attenuation coefficients for the choosen water type.
% b is scattring coefficient
% c is the beam attenuation coeficient
% Kd is the diffuse downwelling attenuation coefficient
Kd = Jerlov_Kd(:,Water_Type);
c = Jerlov_c(:,Water_Type);
b = Jerlov_b(:,Water_Type);


% Scaling parameters
% D = 0
% z = 0
RGB_scale = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, 0, c, 0, b, Cannon_Sc.data(:,2:end));
white_scaling_value = RGB_scale(3,:);



% Simulating RGB values given water type and viewing geometry
[Ic, Dc, Bc] = get_UW_radiance(Refl_spectra_DGK.data(:,2:end)', light_spectra_D65, Kd, Depth, c, Distance, b, Cannon_Sc.data(:,2:end));

% Scaling the simulated RGB values
Ic_scaled = Ic./white_scaling_value;



figure;
imshow(visualizeDGK(mat2gray(Ic_scaled)))


% Create the formatted title
formattedTitle = sprintf('Simulated image of DGK color chart at depth %d[m] viewed from distance %d[m] away', Depth, Distance);
title(formattedTitle);

% Add the subtitle using text
subtitleText = sprintf('Water type is: Jerlov %d', Water_Type);
text(0.5, -0.05, subtitleText, 'Units', 'normalized', 'HorizontalAlignment', 'center', 'FontSize', 20);






%% Exercise 2: Direct signal (Dc) and Backscatter (Bc)


figure;
Dc_scaled = Dc./white_scaling_value;
montage({visualizeDGK(mat2gray(Ic_scaled)), visualizeDGK(mat2gray(Dc_scaled))})


% Create the formatted title
formattedTitle = sprintf('Top image with backscatter - Bottom image without backscatter');
title(formattedTitle);

% Add the subtitle using text
subtitleText = sprintf('Water type is: Jerlov %d, Depth = %d[m], Viewing distance = %d[m]', Water_Type, Depth, Distance);
text(0.5, -0.05, subtitleText, 'Units', 'normalized', 'HorizontalAlignment', 'center', 'FontSize', 15);






%% Exercise 3: Comparing the 8 different Jerlov water types
% Initialize an image array to store the 8 images
% Use a cell array for storing the images
CC_array = cell(1, 8); 



% Total signal (Ic) and Direc signal (Dc) comparison in different water types
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
    [Ic, Dc, Bc] = get_UW_radiance(Refl_spectra_DGK.data(:, 2:end)', light_spectra_D65, Kd, CompDepth, c, CompDistance, b, Cannon_Sc.data(:, 2:end));

    % Normalize the radiance values
    Ic_scaled = Ic./ white_scaling_value;
    Dc_scaled = Dc./ white_scaling_value;

    % Visualize and store the resulting image in the array
    Ic_array{i} = visualizeDGK(mat2gray(Ic_scaled)); 
    Dc_array{i} = visualizeDGK(mat2gray(Dc_scaled)); 
end

% Convert the cell array to a 4D array for montage
Ic_montage = cat(4, Ic_array{:});
Dc_montage = cat(4, Dc_array{:});


% Display the total signal Ic
figure;
montage(Ic_montage, 'Size', [2 4]); 
title('Comparsion of Ic in 8 optically different water types from Jerlovs data-set');

% Display the total signal Dc
figure;
montage(Dc_montage, 'Size', [2 4]); 
title('Comparsion of Dc in 8 optically different water types from Jerlovs data-set');







%% Exercise 4: RGB's (Dc, Bc) as function of viewing distance (z)

% Set parameters
Water_Type = 4;
Depth = 5;
Kd = Jerlov_Kd(:,Water_Type);
c = Jerlov_c(:,Water_Type);
b = Jerlov_b(:,Water_Type);

% Experiment with different patches !!!
patch = 10;


figure;
hold on;
for z = 0:0.5:8
    [Ic, Dc, Bc] = get_UW_radiance(Refl_spectra_DGK.data(:, 2:end)', light_spectra_D65, Kd, Depth, c, z, b, Cannon_Sc.data(:, 2:end));
    plot(z, Dc(patch,1), 'or', 'LineWidth', 2)
    plot(z, Dc(patch,2), 'og', 'LineWidth', 2)
    plot(z, Dc(patch,3), 'ob', 'LineWidth', 2)


    plot(z, Bc(1,1), '^r', 'LineWidth', 2)
    plot(z, Bc(1,2), '^g', 'LineWidth', 2)
    plot(z, Bc(1,3), '^b', 'LineWidth', 2)
end



