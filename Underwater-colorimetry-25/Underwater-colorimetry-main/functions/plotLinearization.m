function plotLinearization(RGB,ref,prs)
%
% OUTIMG = PLOTLINEARIZATION(RGB,REF,PRS)
% 
% RGB     : RGB values corresponding to neutral patches, 3xN
% REF     : The reference luminance (Y) values from the color chart, 1xN.
% PRS     : Linearization parameters for each channel.
%
% This script was modified from the book:
%
% "Computational Colour Science Using MATLAB", Westland & Ripamonti 2004.
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


r = RGB(1,:);
g = RGB(2,:);
b = RGB(3,:);

pr1 = prs(1,:);
pg1 = prs(2,:);
pb1 = prs(3,:);


scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2 0.7*scrsz(3) 0.7*scrsz(4)])
% BEFORE LINEARIZATION
subplot(121)
h(1) = plot(r,ref,'ro','markerfacecolor','k','linewidth',3,'markersize',15);
hold on
x = linspace(0,1,numel(ref));
y = polyval(pr1,x); % just a line that connects these points
h(2) = plot(x,y,'r-','linewidth',5);

h(3) = plot(g,ref,'gs','markerfacecolor','k','linewidth',3,'markersize',10);
y = polyval(pg1,x);
h(4) = plot(x,y,'g-','linewidth',5);

h(5) = plot(b,ref,'bd','markerfacecolor','k','linewidth',3,'markersize',15);
y = polyval(pb1,x);
h(6) = plot(x,y,'b-','linewidth',5);
h(7) = plot(x,x,'k:','linewidth',2);
set(gca,'xlim',[0 1])
set(gca,'ylim',[0 1])
set(gca,'fontsize',20)
xlabel('Luminance values of neutral patches (Y)','fontsize',20)
ylabel('camera intensity for neutral patches','fontsize',20)
hl = legend(h([1 3 5]),{'red channel','green channel','blue channel'});
set(hl,'fontsize',20)
title('BEFORE LINEARIZATION','fontsize',20)

% AFTER LINEARIZATION
subplot(122)

x = linspace(0,1,numel(ref));
y = polyval(pr1,r); % just a line that connects these points
h(1) = plot(ref,y,'r-o','linewidth',5,'markersize',10);
hold on

y = polyval(pg1,g);
h(2) = plot(ref,y,'g-s','linewidth',5);

y = polyval(pb1,b);
h(3) = plot(ref,y,'b-d','linewidth',5);
h(4) = plot(x,x,'k:','linewidth',2);
set(gca,'xlim',[0 1])
set(gca,'ylim',[0 1])
set(gca,'fontsize',20)

xlabel('Luminance values of neutral patches (Y)','fontsize',20)
ylabel('linearized camera intensity for neutral patches','fontsize',20)
hl = legend(h([1 2 3]),{'red channel','green channel','blue channel'});
set(hl,'fontsize',20)
title('AFTER LINEARIZATION','fontsize',20)

