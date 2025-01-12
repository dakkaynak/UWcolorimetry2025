function PlotRGBvsZ(RGB, z)

% PlotRGBvsZ() is plotting RGB vs. distance z
%
% Inputs:
%         RGB  :  RGB values [m x 3]
%         z    :  Distance per RGB [m x 1]
% 
% output:
%         Plot : RGB vs. z


plot(z, RGB(:,1), 'or')
hold on;

plot(z, RGB(:,2), 'og')

plot(z, RGB(:,3), 'ob')



end