% June 8, 2023 modified January 22, 2024
% Underwater Colorimetry Course @ IUI Eilat



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%                               Lab 1                                %%%
%%%     Basic Image Formation and RAW Image Manipulation Exercises     %%%


%%%                             Exercise 3                             %%%
%%%                        Simulation Exercises                        %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all; clc; 


%% Step 1 - Simulate a Macbeth ColorChecker
% Use the function importdata to read the csv files. 
% The importdata function will create a struct with fields: 
% data, textdata, rowheaders. 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the reflectances %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The data will be 25 x 81, where 1st row is wavelength, and
% rows 2-25 are the patches of the color checker.
refl = importdata('data/MacbethColorCheckerReflectances.csv');
% Inspect the data — pay attention that the wavelength range is 380:5:780.
% This commend will print out the wavelength range:
refl.data(1,:)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the relevant camera's curves %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cam = importdata('data/Nikon_D90.csv');
% Again, inspect the wavelength ranges, this dataset is 400:10:700. 
% This commend will print out the wavelength range:
cam.data(:,1)

% Don't forget to also load the second camera!



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load the light data %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

light = importdata('data/illuminant-D65.csv');
% Inspect the wavelength ranges. This dataset is 300:5:830 nm.
light.data(:,1)

% Don't forget to also load the second illuminant!



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Interpolating wavelength to 400:10:700 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This is quite common. 
% We will have to interpolate to a common range of 400:10:700 
% (corresponding to the camera, as that appears to be the coarsest) 
% as follows:

WL = 400:10:700;
refl_spectra = (interp1(refl.data(1,:)',refl.data(2:end,:)',WL))';
% Interpolate values for light
light_spectra = interp1(light.data(:,1),light.data(:,2),WL);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculate radiance for the ColorChecker %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This calculation is for a given illuminant and a given camera!!!

rgb = getradiance(refl_spectra, light_spectra, cam.data(:,2:end));

% Visualize the resulting colors
mcc = visualizeColorChecker(mat2gray(rgb));
figure;imshow(mcc)

% This line saves the figure
% saveas(gcf,'data/Macbeth_no_wb.png');

% Select an achromatic (gray) patch with which to white balance.
% Let's pick the 23rd gray, with 9% reflectance but experiment with
% different patches!
wbpatch = rgb(23,:); 

% perform simple white balancing 
rgb_wb = 0.09*rgb./repmat(wbpatch,[size(rgb,1),1]);

% Visualize the resulting colors
mcc_wb = visualizeColorChecker(rgb_wb);

% Display and save the resulting image
figure;imshow(mcc_wb)
% This line saves the figure
%saveas(gcf,'data/Macbeth_wb.png');

% You should end up with 4 figures of combinations of Illuminant A and D65
% as well as the Nikon and Canon camera. 




%%%%%%%%%    Lab 2 from here    %%%%%%%%%


%% Step 2 -  Calculate the XYZ and xy values of the Macbeth ColorChecker and plot on the chromaticity diagram
% XYZ and xy require us to use the standard observer curves.
close all

% Load standard observer curves
stdobs = importdata('data/CIEStandardObserver.csv');

% interpolate the wl to the same range
stdobs_spectra = interp1(stdobs(:,1),stdobs(:,2:4),WL);

% We can use the same radiance function to calculate XYZ values
XYZ = getradiance(refl_spectra, light_spectra, stdobs_spectra);

% Now obtain xy from XYZ
xy = XYZ./sum(XYZ,2);

% Plot on the chromaticity diagram
plotChromaticity
hold on
% Here I used black squares for each patch, but if you are feeling
% ambitious, you can color them by the patch's own color
plot(xy(:,1),xy(:,2),'ks','markersize',10,'linewidth',3) 
set(gca,'fontsize',30)
set(gca,'xlim',[0 1])
set(gca,'ylim',[0 1])

% You can save using exportgraphics again





%% Step 3: White point xy of an illuminant

% In this case we assume the reflectance is a perfect white
XYZ_light = getradiance(ones(1,numel(WL)), light_spectra, stdobs_spectra);
xy_light = XYZ_light./sum(XYZ_light,2);

% We are plotting this on top of the previous chromaticity diagram we drew
hold on
plot(xy_light(:,1),xy_light(:,2),'kx','markersize',30,'linewidth',3)





%% Step 4: Camera RGB to XYZ transformation

% Recall that we also want the XYZ to be white balanced.
XYZ_wb = XYZ./XYZ_light;

% Derive a 3x3 transform from white balanced camera RGB to white balanced
% XYZ
M = XYZ_wb' * pinv(rgb_wb)';
XYZ_image = (M*rgb_wb')';
% Obtain the xy coordinates
xy_image = XYZ_image./sum(XYZ_image,2);

% Plot them on the chromaticity diagram 
plotChromaticity
hold on
plot(xy_image(:,1),xy_image(:,2),'kx','linewidth',3)

%(remember to overlay the other camera too)





%% Step 5 XYZ to standard RGB transformation

% There are standard matrices for this transformation
% See here --> http://www.brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
% Remember that if XYZ values are already white balanced, there's no need to do a CAT.
figure;
sRGB = xyz2rgb(XYZ_wb);
imshow(visualizeColorChecker(sRGB))

