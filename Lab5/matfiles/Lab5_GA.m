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

%
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
%

% Load GISS-Temperature data: 1880 to today
filename = '../data/gistemp1200_GHCNv4_ERSSTv5.nc';
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
% Average i, i+1, i+2
% Max ind is 1692 to allow J-F-M average for 2021
ind = 1:12:1692;
jfmMean = (globalMonthlyMean(ind) + globalMonthlyMean(ind+1) + globalMonthlyMean(ind+2)) / 3;

% Plot the yearly mean temperature time series just to be safe
fig1 = figure(1);
plot(timeSeries(1:141),globalYearlyMean)
ylim([-.75,1.5])
xlabel('Year')
ylabel('Anomaly (*C)')
title('Global mean annual temperature anomaly, 1880-2020')
figure(gcf)

% Do the scatter plot
fig2 = figure(2);
scatter(timeSeries(1:141),globalYearlyMean)
ylim([-.75,1.5])
xlabel('Year');
ylabel('Anomaly (*C)')
title('Global mean annual temperature anomaly, 1880-2020')
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
% Change X axis to JFM means
% HINT: https://en.wikipedia.org/wiki/Standard_deviation
close([fig1,fig2]);

% Dec 2015 = month 1632, end of year 136
% Jan 2017 = 1655
% Jan 2016 = 1643
% Make polyfit equation, then fill values for series
trend = polyfit(jfmMean(1:136),globalYearlyMean(1:136),1);
trendline = trend(1) * jfmMean(1:136) + trend(2);
detrended = globalYearlyMean(1:136) - trendline;
% Make 2 more lines - trendline + 2*std; trendline - 2*std
upperConfLim = trendline + 2 * std(detrended);
lowerConfLim = trendline - 2 * std(detrended);

% Plot polyfit over scatter
fig3 = figure(3);
plot(jfmMean(1:136),trendline,'-r',...
    jfmMean(1:136),upperConfLim,'-b',...
    jfmMean(1:136),lowerConfLim,'-b')
hold on;
scatter(jfmMean(1:136),globalYearlyMean(1:136))
ylim([-.8,1.4])
yticks([-.8:0.2:1.4])
xlabel('Jan-Feb-March global mean temperature (*C)');
ylabel('Global annual temperature anomaly (*C)')
title('Global mean annual temperature anomaly, 1880-2020')
figure(gcf)

pause

%%

disp(' ')
disp('QUESTION 3: The 95% confidence correspond to approximately how many')
disp('standard deviation away from the mean?'), 
disp(' ') 

disp(' ')
disp('95% confidence corresponds to about 2 standard deviations')
disp(' ')

pause

%%

disp(' ')
disp('QUESTION 4: Plot the projected 2016 temperature based on 2016 JFM')
disp('using a RED CROSS on Fig 2')
disp(' ')
%

disp(['Type Code Here'])
    
pause

%%

disp(' ')
disp('QUESTION 5: How certain (i.e. 90%, 95% or 99%) are you that the ')
disp('2016 global mean yearly mean temperature is the going to be the ')
disp('warmest year on record? PLOT your (90,95 or 99%) confidence interval')
disp('on the figure 2 to justify your answer.')
disp(' ')
%
disp('[TYPE YOUR ANSWER IN WORD]')

% show plot here

disp(['Type Code Here'])

pause

%%

disp(' ')
disp('QUESTION 6: Plot the same projected 2016 temperature +- confidence interval')
disp('in your figure 1 and color in green the actual 2016 Global Mean Yearly')
disp('Mean Temperature Anomaly')
disp(' ')

% Use different color for the projected and actual temperature anomaly for
% clarity
%

disp(['Type Code Here'])

pause

%%
% Q7 + Q8 are optional!!!!!!!!!!!!

%%
%
disp(' ')
disp('QUESTION 7: Plot the projected 2017 temperature +- confidence interval')
disp('in your figure 1 (using a different color)')
disp(' ')
% 

disp(['Type Code Here'])

pause

%%

disp(' ')
disp('QUESTION 8: Is 2017 likely to be the warmest year on record?')
disp(' ')
disp('[TYPE ANSWER HERE] ')
