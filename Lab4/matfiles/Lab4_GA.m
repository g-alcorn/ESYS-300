%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESYS 300 - Earth System Processes
% Laboratory 4: GISS Temperature data analysis
%
% ********  READ CAREFULLY **************
%
% PLEASE work from your dropbox directory.
%
% FOLLOW INSTRUCTION IN [] and READ ALL COMMENTS
%
% Upload your Laboratory on Dropbox by 10:00 AM the day 
% before next class. 
%
% PLEASE RENAME YOUR .m file as Lab4_[YourInitial].m
%
% Hand In only this m-file with your answers inserted within the program below.
% 
% NOTE: I must be able to run your m.file without error message
%   ** Only answers that are requested should be printed (use ; for
%      other intermediate steps).
%   ** If an error occur in the code, I will stop correcting
%   ** No need to hand in your figures and data. I can re-create them by 
%      running your script. 
%   ** If you cannot solve a question, write noting so that the code
%      keeps running.
%
% Skill Tested:
% 1- Locate your data online
% 2- load netcdf data
% 3- Calculate trends
% 4- Calculate statistical significance of trends
% 5- Detrending data.
%

% Laboratory 4: START HERE

% Clear all variables and close all figures

clear all, close all

%%
% Define path

%flag = 'Student' ;
flag = 'Bruno' ;
%flag = 'Firoza' ;

if strcmp(flag, 'Bruno')
    root    = ['/Users/brunotremblay/Dropbox/Teaching/ESYS-300/'] ; 
elseif strcmp(flag, 'Firoza')
    root    = [''] ;
elseif strcmp(flag, 'Student')
    root    = ['C:\Users\Griffin\Desktop\McGill Courses\ESYS-300\Lab4\']
end

MatfilePath = [root 'Matfiles'] ; 
DataPath    = [root 'Data'] ;
PlotPath    = [root 'Plot'] ;

addpath(MatfilePath,DataPath, PlotPath) 

%% 
% NAME:        
%

GivenName   = ['Griffin'] ;                   % ENTER given name
FamilyName  = ['Alcorn'] ;                  % ENTER family name

disp('')
disp(['Name: ', GivenName, ' ', FamilyName])    % Print Full Name
disp('')

pause

% Load GISS Temperature Anomaly, Latitude, Longitude Data.
% Google "NASA GISS global temperature data"
% Locate on the site "Land-Ocean Temperature Index, ERSSTv5, 1200km
% smoothing" under "Compressed NetCDF files (regular 2x2 degree grid)"
% Useful command for netcdf data format: ncread and ncdisp
filename = 'gistemp1200_GHCNv4_ERSSTv5.nc'
lat = ncread(filename,'lat');                   % Degrees N
lon = ncread(filename,'lon');                   % Degrees E
time = ncread(filename,'time');                 % Days since 1800-01-01
time_bnds = ncread(filename,'time_bnds');       % No unit
tempAnomaly = ncread(filename,'tempanomaly');   % Kelvin

%%

disp(' ')
disp('QUESTION 1:')
disp(['Are the temperature anomalies yearly, monthly or daily means?  ', ...
      'What are the units of the time variables?'])
disp(' ')

disp('Temperature anomalies are monthly means.')
disp('The time variable is the number of days since 1800-01-01, starting at 29233.')

pause

%%

disp('')
disp('QUESTION 2: Calculate and plot the Yearly averaged global mean ')
disp('temperature time series')
disp('')

% Always put labels and title on your figures.
% HINT: Remember your friend "whos"
% HINT: The function nanmean(x) calculates the mean of vector x treating 
% the nan as missing values e.g. a = [1 3 nan]; nanmean(a) = 2; mean(a) = nan; 
% When you "mean" a 3D matrix, the third dimension remains as as singleton.
% HINT: squeeze(x) removes the singleton dimension.
% Try "mean" on the 3D matrix and then use whos to see how the dimension of
% the matrix behave before and after "mean" and "squeeze".
% HINT: Use the function reshape, to ease the mean calculation
%

% Calculate Global Monthly Mean Temperature Anomaly
globalMonthlyMean = mean(squeeze(mean(tempAnomaly,'omitnan')),'omitnan');

% Calculate Yearly Mean Global Mean Temperature Anomaly (one temp per year)
% and the time vector
yearlyMean = squeeze(mean(reshape(tempAnomaly(:,:,1:1692),[180,90,12,141]),3,'omitnan'));
globalYearlyMean = squeeze(mean(yearlyMean,1:2,'omitnan'));
timeSeries = 1880:1:2020;

% Plot Yearly Global Mean Temperature Anomaly
% Label your axes, title your figure, use Fonts that are readable

fig1 = figure;
plot(timeSeries,globalYearlyMean)
xlabel('Year')
ylabel('Temperature anomaly (*C)')
title('Global Mean Annual Temperature Anomaly, 1880-present')
figure(gcf);

pause

%%

disp(' ')
disp('QUESTION 3: Calculate and print the trend (slope) in Global Mean ')
disp('Temperature in units of C/decade')
disp(' ')

% Linear trend
trend = polyfit(timeSeries,globalYearlyMean,1);
% Differences between point and trend
y1 = polyval(trend,timeSeries);

disp('The trend (slope) of the Global Mean Temperature is (C/decade):')
disp(['Trend = ', num2str(trend(1)*10), ' *C per decade'])

pause

%%

disp(' ')
disp('QUESTION 4: Overlay the trend line on the same Global Mean ')
disp('Temperature Anomaly time series plot above')
disp(' ')

trendline = trend(1) * timeSeries + trend(2);

plot(timeSeries,globalYearlyMean,timeSeries,trendline)
legend('Global Mean Temperature Anomaly','Trend','Location','southeast')
xlabel('Year')
ylabel('Temperature anomaly (*C)')
title('Global Mean Annual Temperature Anomaly, 1880-present')
figure(gcf);

pause

%%

disp(' ')
disp(['QUESTION 5: Is the temperature trend significant? (Y or N)' ...
      'Show histogram of slopes including the observed trend (or slope)'])
disp(' ')

% Use the "line" command to plot a vertical line in your histogram at a
% value equal to the observed slope for the GISS data.

% Read Tutorial for statistical significance of slopes: Lab 4.
% Statistical Significance of Trend
% First detrend the time series and calculate the standard deviation wrt 
% the detrended time series.
% Generate 1000 random time series with the same number of data points and
% the same standard deviation as the original timeseries (GISS-TEMP).
% Calculate what fraction of your random time series have a trend (or
% slope) that is larger than the observed trend in the GISS-TEMP dataset.


% Detrend temperature time series
detrended = globalYearlyMean - reshape(trendline,141,1);

% Calculate standard deviation of detrended time series
stdevDetrended = std(detrended);
slope = zeros(1000,1);

% Generate a 1000 random time series
% Calculate histogram of slopes
for i = 1:1000
    random = rand(141,1);
    rdm_normalized = random / std(random) * stdevDetrended;
    P = polyfit([1:141]', rdm_normalized,1);
    slope(i) = P(1);                                       
end

% Plot histogram
fig2 = figure;
histogram(slope)
xline(trend(1))
xlabel('Slope')
ylabel('Frequency')
title('Slope distribution of random timeseries')
figure(gcf)

isSignificant = find(slope > trend(1));
disp([num2str(numel(isSignificant)), ' random timeseries have slope greater than the slope of the real data.'])
disp('Therefore there is >99% certainty that the observed trend is not due to random chance.')

pause

%%
% Signature of Global Warming

disp('')
disp('QUESTION 6: Plot the Surface Temperature Anomaly between 2001-15 ')
disp('and 1951-80')
disp('')

% Use the pcolor function to do your surface plot.
% Include a colorbar to your plot and use the shading 'interp'

% Calculate the 15-year mean surface temperature for the 2001-2015 and 
% the 30-year mean for the 1951-1980 time periods.
% Calculate the anomaly between the two surface fields
% Plot the anomaly
% See PowerPoint presentation last slide. This is what you need to
% reproduce.

% 30-year mean will be used as baseline value
% Subtract 30-year mean from 15-year mean for anomaly
% Plot on map
close([fig1, fig2])

fifteenYearMean = mean(tempAnomaly(:,:,1452:1631),3,'omitnan');
thirtyYearMean = mean(tempAnomaly(:,:,852:1211),3,'omitnan');
fifteenYearAnomaly = fifteenYearMean - thirtyYearMean;


fig3 = figure;

mapRef = georefcells([-90 90],[-180 180], [90,180]);
geoshow(transpose(fifteenYearAnomaly),mapRef,'DisplayType','surface')
cb = colorbar('southoutside');
cb.Label.String = 'Temperature anomaly (*C)';
title('2001-15 Mean Surface Temperature Anomaly, 1951-80 base period')
xlim([-180,180])
xlabel('Longitude (degrees)')
ylim([-88,88])
ylabel('Latitude (degrees)')
figure(gcf);

pause

%%

disp('')
disp('QUESTION 7: Overlay continents on your previous figure using geoshow')
disp('Do not include lat and lon labels')
disp(' ')

% HINT: meshgrid is a useful command for these applications
% HINT: 'FaceAlpha' is the property that sets the transparency of an object
% HINT: the command "colormap" used to specify colormap
% HINT: Use mercator projection


% https://www.mathworks.com/help/map/summary-and-guide-to-projections.html
% Create map, set projection type, set Latitudes limits 
close(fig3)

fig4 = figure;

geoshow(transpose(fifteenYearAnomaly),mapRef,'DisplayType','surface','FaceAlpha','0.8')
geoshow('landareas.shp','FaceColor','white')
colormap(jet)
cb = colorbar('southoutside');
cb.Label.String = 'Temperature anomaly (*C)';
title('2001-15 Mean Surface Temperature Anomaly, 1951-80 base period')
axesm('mercator')
xlim([-180,180])
ylim([-88,88])

figure(gcf);
