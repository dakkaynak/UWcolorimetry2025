% June 8, 2023 modified January 22, 2024
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 2                                %%%
%%%                    Basic Colorimetry Exercises                     %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  LAB 2:  
%           Exercise 1: Quantitative color comparison 
%           Exercise 2: RGB to XYZ transformation
%           Exercise 3: xy white point coordinates
%           Exercise 4: XYZ to Standard RGB transformation


clear all; close all; clc; 


%% Exercise 1: Quantitative color comparison 

% Import all necessary data

% Reflectance of the color chart
refl = importdata('data/MacbethColorCheckerReflectances.csv');

% Cameras sensitivities
nikon = importdata('data/Nikon_D90.csv');
canon = importdata('data/Canon_1Ds-Mk-II.csv');

% Illuminant (such as D65)
light = importdata('data/illuminant-D65.csv');

% Wavelength range 400-700[nm]
WL = 400:10:700;



% Interpolate data to wavelength range  
refl_spectra = (interp1(refl.data(1,:)',refl.data(2:end,:)',WL))';
light_spectra = interp1(light.data(:,1),light.data(:,2),WL);

% get RGB values 
rgb_nikon = getradiance(refl_spectra, light_spectra, nikon.data(:,2:end));
rgb_canon = getradiance(refl_spectra, light_spectra, canon.data(:,2:end));




% Plot results 
% Red channel
subplot(3,1,1)
plot(rgb_nikon(:,1),'o')
hold on
plot(rgb_canon(:,1),'*')
title('R channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')

% Green channel
subplot(3,1,2)
plot(rgb_nikon(:,2),'o')
hold on
plot(rgb_canon(:,2),'*')
title('G channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')

% Blue channel
subplot(3,1,3)
plot(rgb_nikon(:,3),'o')
hold on
plot(rgb_canon(:,3),'*')
title('B channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%   Don't forget to add the third camera to the plot!   %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Exercise 2: RGB to XYZ transformation

% Load standard observer curves
stdobs = importdata('data/CIEStandardObserver.csv');

% Interpolate data to wavelength range  
stdobs_spectra = interp1(stdobs(:,1),stdobs(:,2:4),WL);

% get XYZ values 
XYZ = getradiance(refl_spectra, light_spectra, stdobs_spectra);

% In this case we assume the reflectance is a perfect white
XYZ_light = getradiance(ones(1,numel(WL)), light_spectra, stdobs_spectra);
xy_light = XYZ_light./sum(XYZ_light,2);

% Recall that we also want the XYZ to be white balanced.
XYZ_wb = XYZ./XYZ_light;



%%%%%%%%%%%%%
%%% Canon %%%
%%%%%%%%%%%%%

% Select an achromatic patch with which to white balance.
% Let's pick the 23rd gray, with 9% reflectance but experiment with
% different patches!
wbpatch = rgb_canon(23,:); 

% perform simple white balancing for rgb
rgb_wb_canon = 0.09*rgb_canon./repmat(wbpatch,[size(rgb_canon,1),1]);

% Derive a 3x3 transform from white balanced camera RGB to white balanced
% XYZ 
T_canon=XYZ_wb'*pinv(rgb_wb_canon)';
xyz_image_canon = (T_canon*rgb_wb_canon')';

% Obtain the xy coordinates
xy_image_canon = xyz_image_canon./sum(xyz_image_canon,2);



%%%%%%%%%%%%%
%%% Nikon %%%
%%%%%%%%%%%%%

% Select an achromatic patch with which to white balance.
% Let's pick the 23rd gray, with 9% reflectance but experiment with
% different patches!
wbpatch = rgb_nikon(23,:); 

% perform simple white balancing for rgb
rgb_wb_nikon = 0.09*rgb_nikon./repmat(wbpatch,[size(rgb_nikon,1),1]);

% Derive a 3x3 transform from white balanced camera RGB to white balanced
% XYZ 
T_nikon=XYZ_wb'*pinv(rgb_wb_nikon)';
xyz_image_nikon = (T_nikon*rgb_wb_nikon')';

% Obtain the xy coordinates
xy_image_nikon = xyz_image_nikon./sum(xyz_image_nikon,2);



 %%%%%%%%%%%%%%%%%% plots %%%%%%%%%%%%%%%%%%
 figure;
 plotChromaticity
 hold on
 plot(xy_image_nikon(:,1),xy_image_nikon(:,2),'go','linewidth',3)
 hold on
 plot(xy_image_canon(:,1),xy_image_canon(:,2),'bo','linewidth',3)
 title('Canon and Nikon Chromaticity plot')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%   Don't forget to add the third camera to the plot!   %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Exercise 3: xy white point coordinates
% We are plotting the white point on top of the previous chromaticity diagram we drew
hold on
plot(xy_light(:,1),xy_light(:,2),'k^','markersize',10,'linewidth',3)




%% Exercise 4: XYZ to Standard RGB transformation
% Calculate camera xyz to sRGB
sRGB_canon = xyz2rgb(xyz_image_canon);
sRGB_nikon = xyz2rgb(xyz_image_nikon);

% Plot results 
figure
nexttile;
imshow(visualizeColorChecker(sRGB_nikon));
title('Nikon Color Checker', 'FontSize', 14, 'Color', 'k');

% Display the second image with a title
nexttile;
imshow(visualizeColorChecker(sRGB_canon));
title('Canon Color Checker', 'FontSize', 14, 'Color', 'k');



figure
% Red channel
subplot(3,1,1)
plot(sRGB_nikon(:,1),'o')
hold on
plot(sRGB_canon(:,1),'*')
title('R channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')

% Green channel
subplot(3,1,2)
plot(sRGB_nikon(:,2),'o')
hold on
plot(sRGB_canon(:,2),'*')
title('G channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')

% Blue channel
subplot(3,1,3)
plot(sRGB_nikon(:,3),'o')
hold on
plot(sRGB_canon(:,3),'*')
title('B channel')
legend('Nikon data','Canon data')
xlabel('Patch #')
ylabel('Intensity')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%   Don't forget to add the third camera to the plot!   %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

