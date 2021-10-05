%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESYS 300 - Earth System Processes
% Laboratory 5: GISS Temperature data analysis (continued)
%
% ********  READ CAREFULLY **************
%
% PLEASE work from your dropbox directory.
%
% FOLLOW INSTRUCTION IN [] and READ ALL COMMENTS
%
% Upload your Laboratory on both Dropbox and MyCourses by 12:00 PM the day 
% before next class. 
%
% PLEASE RENAME YOUR .m file as Lab2_[YourInitial].m
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
% 1- Calculate confidence interval
% 2- Calculate (lagged) correlation
% 3- Calculate trends
%
%
%%
% Laboratory 5: START HERE

% In this Laboratory, you will use the GISS-Temperature in order to study 
% the predictibility of the Global Mean Surface Temperatures. In 
% particular, you will use the mean surface temperature anomaly of the 
% first 3-months of the year as a predictor for the full year mean surface 
% temperature anomaly (9-month lead time). 
% In a second step (optional), you will use the temperature anomaly only in the 
% Equatorial Pacific (El Nino region) from the previous year as a predictor 
% for the following year global mean temperature anomaly (1 year lead time).
% All of this highlights the memory of the system associated with the
% thermal inertia of the surface ocean - which gives rise to predictability.
% READING: 
% http://fivethirtyeight.com/features/why-we-dont-know-if-it-will-be-sunny-next-month-but-we-know-itll-be-hot-all-year/
%

% Clear all variables and close all figures

clear all, close all

% Define path

flag = 'Student' ;
%flag = 'Bruno' ;
%flag = 'Firoza' ;

if strcmp(flag, 'Bruno')
    root    = ['/Users/brunotremblay/Dropbox/Teaching/ESYS-300/'] ; 
elseif strcmp(flag, 'Firoza')
    root    = [''] ;
elseif strcmp(flag, 'Student')
    root    = ['C:\Users\Griffin\Desktop\McGill Courses\ESYS-300\Lab5\']                 % EDIT root with your credential.
end

MatfilePath = [root 'Matfiles'] ; 
DataPath    = [root 'Data'] ;
PlotPath    = [root 'Plot'] ;

addpath(MatfilePath,DataPath, PlotPath) 

% 
% NAME:        

GivenName   = ['Griffin'] ;                   % ENTER given name
FamilyName  = ['Alcorn'] ;                  % ENTER family name

disp(' ')
disp(['Name: ', GivenName, ' ', FamilyName])    % Print Full Name
disp(' ')

%%
disp(' ')
disp('QUESTION 1: Do a scatter plot of Global Jan-Feb-Mar Mean temperature anomaly')
disp('as a function of the Global Yearly Mean temperature anomaly from 1880 to 2015')
disp(' ')

% Load GISS-Temperature data: 1880 to today
filename = 'gistemp1200_GHCNv4_ERSSTv5.nc';
lat = ncread(filename,'lat');                   % Degrees
lon = ncread(filename,'lon');                   % Degrees
time = ncread(filename,'time');                 % Days since 1800-01-01
tempAnomaly = ncread(filename,'tempanomaly');   % Kelvin
timeSeries = transpose(1880:1:2021);

% Calculate the Yearly and JFM means
% Reshape tempAnomaly into 4-D array where 3rd dimension is each year
% Mean each year and squeeze down to 141x1 vector
% yearlyMean must omit indices 1693-1700 because year is incomplete
yearlyMean = squeeze(mean(reshape(tempAnomaly(:,:,1:1692),[180,90,12,141]),3,'omitnan'));
globalYearlyMean = squeeze(mean(yearlyMean,1:2,'omitnan'));

% Mean in 2nd dimension, removes latitude
% Mean in 1st dimension, remove longitude
% Squeeze removes empty dimensions
% globalMonthlyMean has 1700 entries
monthlyMeanLat = squeeze(mean(tempAnomaly(:,:,1:1700),2,'omitnan'));
globalMonthlyMean = transpose(squeeze(mean(monthlyMeanLat,1,'omitnan')));

% Use modified rolling-average method to get J-F-M average
% Index jumps 1 year
% Max ind is 1695 to allow J-F-M average for 2021
ind = 1:12:1704;
jfmMean = (globalMonthlyMean(ind) + globalMonthlyMean(ind+1) + globalMonthlyMean(ind+2)) / 3;

% Plot the yearly mean temperature time series just to be safe
figure
subplot(2,1,1)
plot(timeSeries(1:141),globalYearlyMean)
ylim([-0.75,1.5])
xlabel('Year')
ylabel('Annual temp anomaly (*C)')
title('Global mean annual temperature anomaly, 1880-2020')

% Do the scatter plot
subplot(2,1,2)
scatter(jfmMean(1:141),globalYearlyMean,24,'k','.')
ylim([-0.75,1.5])
xlabel('Global Mean Jan-Feb-Mar temp anomaly (*C)');
ylabel('Annual temp anomaly (*C)')
title('Global mean annual anomaly vs mean Jan-Feb-mar anomaly')
figure(gcf)

pause

%%
% Pretend here that we are on April 1 2016.
% Use the data from 1880 to December 2015 for the best linear fit
% Use JFM of 2016 for the projection.
% Use yearly 2016 mean to compare your projection with reality
% We will use 2017 to repeat the exercise.
disp(' ')
disp('QUESTION 2: Calculate and plot the best linear fit and 95% confidence')
disp('interval on your figure 2')
disp(' ')
close(gcf);

% HINT: https://en.wikipedia.org/wiki/Standard_deviation
% 95% confidence = 1.959964 * std
confFactor95 = 1.959964;

% Dec 2015 = month 1632, end of year 136
% Jan 2016 = 1633
% Apr 2016 = 1636
% Make polyfit equation, then fill values for series
trend = polyfit(jfmMean(1:135),globalYearlyMean(1:135),1);
trendline = polyval(trend, jfmMean(1:135));
detrended = globalYearlyMean(1:135) - trendline;

% Make 2 more lines - trendline + 2*std; trendline - 2*std
upperConfLim = trendline + confFactor95 * std(detrended);
lowerConfLim = trendline - confFactor95 * std(detrended);

% Plot polyfit over scatter
fig2 = figure(2);
scatter(jfmMean(1:135),globalYearlyMean(1:135),24,'k','.')
hold on;
plot(jfmMean(1:135),trendline,'-m',...
     jfmMean(1:135),upperConfLim,'-b',...
     jfmMean(1:135),lowerConfLim,'-b')
ylim([-0.8,1.4])
yticks([-0.8:0.2:1.4])
xlabel('Global mean Jan-Feb-Mar temperature anomaly (*C)');
ylabel('Annual temp anomaly (*C)')
title('Global mean annual anomaly vs mean Jan-Feb-mar anomaly, 1880-2015')
legend('Data','Line of best fit',...
       '95% confidence limit',...
       'Location','southoutside')
figure(gcf)

pause

%%
disp(' ')
disp('QUESTION 3: The 95% confidence correspond to approximately how many')
disp('standard deviation away from the mean?'), 
disp(' ') 

disp(' ')
disp('95% confidence corresponds to 1.959964 standard deviations,')
disp('according to Wikipedia.')
disp(' ')

pause

%%
disp(' ')
disp('QUESTION 4: Plot the projected 2016 temperature based on 2016 JFM')
disp('using a RED CROSS on fig from Q2')
disp(' ')
close(gcf)

% 2016 is year 137
projection = polyval(trend, jfmMean(137));

fig3 = figure(3);
scatter(jfmMean(1:135),globalYearlyMean(1:135),24,'k','.')
hold on
plot(jfmMean(137),projection,'xr',...
     jfmMean(1:135),trendline,'-m',...
     jfmMean(1:135),upperConfLim,'-b',...
     jfmMean(1:135),lowerConfLim,'-b')
ylim([-0.8,1.6])
yticks([-0.8:0.2:1.6])
xlabel('Global mean Jan-Feb-Mar temperature anomaly (*C)')
ylabel('Annual temp anomaly (*C)')
title('Predicting 2016 global mean annual temperature anomaly')
legend('Data','Projected 2016 temperature anomaly',...
       'Line of best fit',...
       '95% confidence limit',...
       'Location','southoutside')
figure(gcf)

pause

%%
disp(' ')
disp('QUESTION 5: How certain (i.e. 90%, 95% or 99%) are you that the ')
disp('2016 global mean yearly mean temperature is the going to be the ')
disp('warmest year on record? PLOT your (90,95 or 99%) confidence interval')
disp('on the fig from Q2 to justify your answer.')
disp(' ')

disp('I am 99% certain the projected 2016 global mean annual temperature')
disp('will be the highest on record.')
disp('The lower limit of the 99% confidence interval is y = 0.958278.')
disp('The highest value of the 1880-2015 data is y = 0.919214.')
close(gcf)

% 99% confidence = 2.575829 * std
confFactor99 = 2.575829;

fig4 = figure(4);
scatter(jfmMean(1:135),globalYearlyMean(1:135),24,'k','.')
hold on
errorbar(jfmMean(137),projection,2.575829*std(detrended),'xr')
hold on
plot(jfmMean(1:135),trendline,'-m',...
     jfmMean(1:135),upperConfLim,'-b',...
     jfmMean(1:135),lowerConfLim,'-b')
ylim([-0.8,2])
xlabel('Global mean Jan-Feb-Mar temperature anomaly (*C)')
ylabel('Annual temp anomaly (*C)')
title('Predicting 2016 global mean annual temperature anomaly')
legend('Data','Projected 2016 temperature anomaly with 99% C.I.',...
       'Line of best fit',...
       '95% confidence limit',...
       'Location','southoutside')
figure(gcf)

pause

%%
disp(' ')
disp('QUESTION 6: Plot the same projected 2016 temperature +- confidence interval')
disp('in your figure 1 and color in green the actual 2016 Global Mean Yearly')
disp('Mean Temperature Anomaly')
disp(' ')
close(gcf)

fig5 = figure(5);
plot(timeSeries(1:136),globalYearlyMean(1:136))
hold on
errorbar(timeSeries(137),projection,2.575829*std(detrended),'xr')
hold on
plot(timeSeries(137),globalYearlyMean(137),'*g')
ylim([-0.8,2])
xlabel('Year')
ylabel('Annual temp anomaly (*C)')
title('Global mean annual temperature anomaly, 1880-2016')
legend('Global mean annual temperature anomaly',...
       'Projected 2016 temperature anomaly with 99% C.I.',...
       'Actual 2016 temperature anomaly',...
       'Location','southoutside')
figure(gcf)

pause

%%
% Q7 + Q8 are optional!!!!!!!!!!!!

%%
%
% disp(' ')
% disp('QUESTION 7: Plot the projected 2017 temperature +- confidence interval')
% disp('in your figure 1 (using a different color)')
% disp(' ')
% % 
% 
% disp(['Type Code Here'])
% 
% pause

%%

% disp(' ')
% disp('QUESTION 8: Is 2017 likely to be the warmest year on record?')
% disp(' ')
% disp('[TYPE ANSWER HERE] ')
