function XYZ = getChartXYZvalues(chart,colors)
%
% XYZ = GETCHARTXYZVALUES(CHART,COLORS)
%
% CHART     : struct containing properties of the color chart. see
% macbethColorChecker.m for the format.
% COLORS    : cell array containing the names, or numbers of color patches
% in the chart being used. see macbethColorChecker.m for the format.
% XYZ     : XYZ values corresponding to each patch, 
%           size size(colors,1) * size(colors,2) x 3
%
% ************************************************************************
% If you use this code, please cite the following paper:
%
%
% <paper>
%
% ************************************************************************
% For questions, comments and bug reports, please use the interface at
% Matlab Central/ File Exchange. See paper above for details.
% ************************************************************************


n = 1;
s = size(colors);
XYZ = zeros(s(1)*s(2),3);
for row = 1:s(1)
    for col = 1:s(2)
        curColor = colors{row,col};
        XYZ(n,:) = chart.(curColor).xyz;
        n = n+1;
    end
end