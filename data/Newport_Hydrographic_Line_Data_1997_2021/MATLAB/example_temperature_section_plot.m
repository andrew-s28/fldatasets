clearvars
close all

%load data
time = double(ncread('newport_hydrographic_line_gridded_sections.nc','time'))+datenum(1970,1,1);
pressure = double(ncread('newport_hydrographic_line_gridded_sections.nc','pressure'));
latitude = ncread('newport_hydrographic_line_gridded_sections.nc','latitude');
longitude = double(ncread('newport_hydrographic_line_gridded_sections.nc','longitude'));
temperature = squeeze(ncread('newport_hydrographic_line_gridded_sections.nc','temperature'));

%load bathymetry data
bathymetry_data = csvread('newport_hydrographic_line_bathymetry.csv',1,0);

%Make a plot
figure('units','normalized','outerposition',[0 0 1 1])
[~,h]=contourf(longitude,pressure,squeeze(temperature(556,:,:)),0:.1:30);
set(h,'LineColor','none')
hold on
[c,h]=contour(longitude,pressure,squeeze(temperature(556,:,:)),0:1:30,'k','linewidth',1);
h.LevelList=round(h.LevelList,2);
clabel(c,h,'fontsize',16);
caxis([7 14])
colormap(cmocean('thermal')) %https://www.mathworks.com/matlabcentral/fileexchange/57773-cmocean-perceptually-uniform-colormaps
xlim([235.35 235.9]);
ylim([0 150]);
set(gca,'XTick',235.4:.1:235.9,'XTickLabel',-124.6:.1:-124.1,'fontsize',16)
set(gca,'YDir','reverse')
set(gca,'YTick',0:25:150,'YTickLabel',0:25:150,'fontsize',16)
xlabel('Longitude (^oW)','fontsize',16);
ylabel('Pressure (dbar)','fontsize',16);
title(datestr(time(556),1),'fontweight','normal');
h=colorbar;
set(h,'YTick',[7 8 9 10 11 12 13 14],'YTickLabel',[7 8 9 10 11 12 13 14],'fontsize',16)
title(h,'^oC','fontsize',16);
plot(bathymetry_data(:,1),bathymetry_data(:,2)*-1,'k')
