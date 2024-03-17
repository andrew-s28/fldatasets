clearvars
close all

%load data
coefficient_number = double(ncread('newport_hydrographic_line_gridded_section_coefficients.nc','coefficient_number'));
pressure = double(ncread('newport_hydrographic_line_gridded_section_coefficients.nc','pressure'));
latitude = ncread('newport_hydrographic_line_gridded_section_coefficients.nc','latitude');
longitude = double(ncread('newport_hydrographic_line_gridded_section_coefficients.nc','longitude'));
temperature_coefficients = squeeze(ncread('newport_hydrographic_line_gridded_section_coefficients.nc','temperature_coefficients'));

%load bathymetry data
bathymetry_data = csvread('newport_hydrographic_line_bathymetry.csv',1,0);

%Calculate daily temperature climatology: Jan 1 - Dec 31
f=1/365.2422;
new_t=0:1:364;
seasonal_cycle_temperature_daily = nan(150,56,365);
for ii = 1:150
    for jj = 1:56
        seasonal_cycle_temperature_daily(ii,jj,:) = (temperature_coefficients(1,ii,jj)+...
            temperature_coefficients(2,ii,jj)*sin(2*pi*f*new_t)+temperature_coefficients(3,ii,jj)*cos(2*pi*f*new_t)+...
            temperature_coefficients(4,ii,jj)*sin(4*pi*f*new_t)+temperature_coefficients(5,ii,jj)*cos(4*pi*f*new_t)+...
            temperature_coefficients(6,ii,jj)*sin(6*pi*f*new_t)+temperature_coefficients(7,ii,jj)*cos(6*pi*f*new_t));
    end
end

%Calculate monthly means: January - December
seasonal_cycle_temperature_monthly = nan(150,56,12);
month=str2num(datestr(datenum(1999,1,1):datenum(1999,12,31),5));
for ii = 1:12
    seasonal_cycle_temperature_monthly(:,:,ii) = nanmean(seasonal_cycle_temperature_daily(:,:,ii==month),3);
end

%Make a plot
figure('units','normalized','outerposition',[0 0 1 1])
[~,h]=contourf(longitude,pressure,squeeze(seasonal_cycle_temperature_monthly(:,:,1)),0:.1:30);
set(h,'LineColor','none')
hold on
[c,h]=contour(longitude,pressure,squeeze(seasonal_cycle_temperature_monthly(:,:,1)),0:1:30,'k','linewidth',1);
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
title('January','fontweight','normal');
h=colorbar;
set(h,'YTick',[7 8 9 10 11 12 13 14],'YTickLabel',[7 8 9 10 11 12 13 14],'fontsize',16)
title(h,'^oC','fontsize',16);
plot(bathymetry_data(:,1),bathymetry_data(:,2)*-1,'k')
