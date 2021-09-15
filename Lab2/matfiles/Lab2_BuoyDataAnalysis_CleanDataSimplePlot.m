%%
% ESYS 300 - Earth System Processes
% Laboratory #2
%
% ********  READ CAREFULLY **************
%
% YOU NEED to download dropbox on your laptop.
%
% PLEASE work from your dropbox directory.
%
% FOLLOW INSTRUCTIONS IN [] and READ ALL COMMENTS
%
% Upload your Laboratory on Dropbox by 12:00 PM the day before next class. 
%
% PLEASE RENAME YOUR .m file as Lab2_[YourInitial].m
%
% Hand In only this m-file with your answers inserted within the program below.
% 
% NOTE: 
%   ** I must be able to run your m.file without error message
%   ** Only answers that are requested should be printed (use ; for
%      other intermediate steps).
%   ** If an error occur in the code, I will stop correcting
%   ** No need to hand in your figures and data. I can re-create them by 
%      running your script. 
%   ** If you cannot solve a question, write noting so that the code
%      keeps running.
% 
% Skill Tested:
% 1- clean-up raw data for analysis
% 2- find, isnan, [], end, hist command
% 3- Linear interpolation/extrapolation
% 4- Data Pre and Post-processing
%
% Matlab Skill learned:
% 1- Plot
% 2- navigate directories, linux
%
%%

clear all, close all

%%
% Define path




root    = ['/Users/brunotremblay/Dropbox/Teaching/ESYS-300/'] ; 



MatfilePath = [root 'Matfiles'] ; 
DataPath    = [root 'Data'] ;
PlotPath    = [root 'Plot'] ;

addpath(MatfilePath,DataPath, PlotPath) 

%%

% Laboratory #2: START HERE
%
% 
% NAME:      

GivenName   = ['Griffin'] ;                   % [ENTER given name]
FamilyName  = ['Alcorn'] ;                  % [ENTER family name]

disp(' ')
disp(['Name: ', GivenName, ' ', FamilyName])    % Print Full Name
disp(' ')

%%
% Spherical Velocity Program (SVP) or Spherical Drifter Data Analysis
% ===================================================================
% 
% Basic useful command to quickly assess and clean datasets
%
% isnan(x)      is used to find NaN in a dataset.
% hist(x)       is used to show a histogram of the data - useful to quickly
%               detect erroneous data
% sum and isnan is used to find out how many NaN exist in a dataset
% []            is used to delete entire row/column of data
% numel(x)      or size(x,1) tells you how many data points there are in x
%

% Load the file from buoy SVP0070RF on MyCourse in the Laboratory section.
% The file is called: Lab2_SVP0070RF_raw_ModifiedJday.mat
%
% Always REMEMBER your best friend "whos" or "whos 'variable name'"

% CONTEXT: This file contains ice buoy data (time, latitude and longitude)
% from a buoy that was deployed in the Canadian Arctic Archipelago.
% The buoy was powered ON at the Polar Shelf ice camp in Resolute Bay;
% it was then carried on board a Twin Otter plane several hundred kms 
% north west of the base, where it was deployed. For this reason you 
% will see large buoy motion near the beginning of the time series 
% These are not meaningful and should be removed (see below).
%
% In the Julian Calandar, days are numbered as JDay = 1, 2, 3, ..., 365
% If a dataset spans more than one year, JDay = 1, 2, ..., 365, 366, 367...
%

% Load data in matlab (.mat) format
% (we will learn later different load statements for different data format)

load('../data/Lab2_SVP0070RF_raw_ModifiedJday.mat')

disp(' ')
disp('QUESTION 1: Convince yourself (and me) that the data is stored in')
disp('three columns, consisting of times, latitudes and longitudes')
disp(' ')

whos Jday
whos latitude
whos longitude

pause

%%

disp('QUESTION 2: Print the first 10 lines of data for each column vectors')
disp('Always look at your data, get to know them! ')
disp('Units, order of magnitude, data type')

disp('Jday: ')
disp(Jday(1:10))
disp('Latitude: ')
disp(latitude(1:10))
disp('Longitude: ')
display(longitude(1:10))

pause

%%

disp(' ')
disp('QUESTION 3: What are the units of time, latitude and longitude?')
disp('HINT: the buoy was deployed in the Canadian Arctic Archipelago in May')
disp(' ')

disp('Time is measured in days since the beginning of the year (1 = January 1st). Latitude and longitude are both in degrees.') 

pause

%%
% First thing to do when you analyze a dataset is to check and remove any 
% obvious erroneous data points in the lat and lon vectors ONLY (e.g. NaN).
% Note that we can tolerate NaN in the time variable since we know the
% frequency at which the data was collected (or delta t between measurements)
% and we can recreate the missing values if we need using interpolation
% or extrapolation.
% NOTE: that if you have one NaN in either Lat or Lon, you need to
% remove the entire row of data.
% HINT: The commands sum, isnan and [] are useful to remove data points
%

disp(' ')
disp('QUESTION 4: How many NaNs are there in the longitude, latitude and ')
disp('time vectors, respectively')
disp(' ')

['Jday   ', 'latitude    ', 'Longitude   ']                    
sumNaN = [sum(isnan(Jday)), sum(isnan(latitude)), sum(isnan(longitude))];
disp(sumNaN)

pause 

%%

disp(' ')
disp('QUESTION 5: Remove the NaNs in lat and lon ONLY in your data set')
disp('How many rows of data did you remove? ')
disp('Store all three vectors in one single matrix for a cleaner process')
disp('Be effective, at most four line of code is necessary')
disp(' ')

% Put the individual vectors into a single matrix
data = [Jday, latitude, longitude];

% Conditional statement to find NaN values ONLY in lat/long columns
nanSet = find( isnan(data(:,2)) | isnan(data(:,3)) );
% Removes rows with NaN values in data
data(nanSet,:) = [];

disp('Rows removed: ')
disp(length(nanSet))

pause

%%

% A nice/efficient way to spot other types of erroneous data is to use the
% command "hist" ("hist" for histogram).

disp(' ')
disp('QUESTION 6: Plot in three separate figures the histogram of Jday,')
disp('longitude and latitude, respectively')
disp(' ')

histogram(data(:,1));
title('Jday distribution');
xlabel('Julian Day number');
ylabel('Frequency');
pause

histogram(data(:,2));
title('Latitude distribution');
xlabel('Latitude (degrees)');
ylabel('Frequency');
pause

h3 = histogram(data(:,3));
title('Longitude distribution');
xlabel('Longitude (degrees)');
ylabel('Frequency');
pause

%%

disp(' ')
disp('QUESTION 7: What are latitude and longitude data value in your')
disp('histogram that are clearly wrong?')
disp('HINT: use the "zoom" commmand on the top bar of your figure')
disp(' ')

h3.BinEdges = [-10:0];
disp('Latitude and Longitude both have 21 instances where the value is 0')

pause

%%

disp(' ')
disp('QUESTION 8: Remove those erroneous data points in lat OR lon')
disp('Print the min and max values of latitude and longitude to check')
disp('Lat_min  Lon_min  Lat_max  Lon_max')
disp(' ')

zeroSet = find( data(:,2) == 0 | data(:,3) == 0 );
data(zeroSet,:) = [];

disp('Rows removed: ')
length(zeroSet)
Lat_min = min(data(:,2))
Lat_max = max(data(:,2))
Lon_min = min(data(:,3))
Lon_max = max(data(:,3))

pause

%%
% Another useful way to find out what the data look like is to
% plot all the data points
%

disp(' ')
disp('QUESTION 9: Plot the buoy trajectory on an x-y (lon/lat) plot')
disp('Label your x- and y-axes including the units of each variable')
disp(' ')

plot(data(:,3),data(:,2))
ylabel('Latitude (deg)')
xlabel('Longitude (deg)')
title('Buoy Trajectory')

pause

%%

% MORE CLEANING:
% Notice the large motion near the beginning of the time series - check the
% numbers on the longitude axis of your plot. This is the plane carrying
% the buoy. Delete those data. Devise a way to find out how many data point 
% you need to remove at the beginning of the time series.


disp(' ')
disp('QUESTION 10: Remove in-plane buoy data. ')
disp('Plot the new ice-only buoy trajectory and label your axes')
disp(' ')

airplanePoints = find(data(1:500,3) > -104.9446);
data(airplanePoints,:) = [];

plot(data(:,3),data(:,2))
ylabel('Latitude (deg)')
xlabel('Longitude (deg)')
title('Ice-Only Buoy Trajectory')
pause


%%
% Now interpolate and/or extrapolate the time vector to fill in the missing
% values. 
% NOTE: In this laboratory, you will learn how to interpolate. I am giving 
%       an example of extrapolation as well for students interested.
% HINT: the function INTERP1 is useful to interpolate data using MATLAB
% HINT: the functions POLYFIT and POLYVAL are useful to interpolate or 
%       extrapolate data in MATLAB.
%

%
% Simple example to fill (interpolate) missing data using interp1.
%

% (x1,y1) = (1,2); (x2,y2) = (2,4); What is value of y at x = 1.5? 
% We know that the answer is 3 since 1.5 is exactly half way between 1
% and 2 and therefore the answer must be exactly half way between 2 and 4.
% Let's do it using interp1 now.
% [GA: Do this example in class. Go slowly. Read the help with them. Bring
% markers and do it on the white board with them and deriving the equation
% of the line and then sticking the value 1.5 into x. I.e. the good old
% fashion way].

x  = [1,2] ;                        % vector x
y  = [2,4] ;                        % vector y
xp = [1.5] ;                        % I want to know yp (y') at xp.
yp = interp1(x,y,xp)                % answer we are looking for.

% NOTE that if you are trying to enter an "xp" that is outside the range of
% x, you will get a NaN as a response. I.e. this function does not allow
% you to extrapolate; just interpolate. To extrapolate, you need to use
% "polyfit". See below for an example.
%
% Simple example to find the best line fit.
% This can then be used to extrapolate

x  = [0 1 2] ;                      % original dataset
y  = [0 1 2] ;                      % original dataset
P  = polyfit(x,y,1)                 % matlab answer P = [m, b] = [1 0] ; 
                                    % y = m x + b or y = P(1) x + P2)
xp = 3 ;                            % What is yp at x = xp? i.e. extrapolate
yp = polyval(P,xp) 


% BACK TO THE BUOY DATA.

%%
disp(' ')
disp('QUESTION 11: Fill in the NaNs in the time vector with correct times')
disp('Do not show the new time vector on screen.')
disp('Instead, plot (using subplot) the old and new time vectors to show') 
disp('that there are no missing data in the new time vector.')
disp(' ')

oldTime = data(:,1);
timeNaN = find(isnan(data(:,1)));

% There are three gaps in the data
% Gap 1 is a single element
y = [data(timeNaN(1)-1,1), data(timeNaN(1)+1,1)];
x = [timeNaN(1)-1,timeNaN(1)+1];
xp = [timeNaN(1)];
data(timeNaN(1),1) = interp1(x,y,xp);

% Gap 2 ranges from X=6368 to X=6472
y = [data(6368,1), data(6472,1)];
x = [6368, 6472];
xp = [6369:1:6471];
data(xp,1) = interp1(x,y,xp);

% Gap 3 ranges from X=9072 to X=9074
y = [data(9072,1), data(9074,1)];
x = [9072, 9074];
xp = [9073];
data(xp,1) = interp1(x,y,xp);

% Gap 4 ranges from X=19618 to X=29620
y = [data(19618,1), data(29620,1)];
x = [19618, 29620];
xp = [19619:1:29620];
data(xp,1) = interp1(x,y,xp);

% Gap 5 ranges from X=32970 to X=32986
y = [data(32970,1), data(32986,1)];
x = [32970, 32986];
xp = [32971:1:32986];
data(xp,1) = interp1(x,y,xp);

% Display on 2x1 plot
subplot(2,1,1);
plot(data(:,1))
title('Jday with NaN removed via interpolation')
subplot(2,1,2);
plot(oldTime)
title('Jday with NaN')

% Added to make testing work
anew = data;

% DO NOT REMOVE THOSE LINES of CODE BELOW. This is for me to check if you have successfully removed the NaN.

disp(['Number of NaN = ', int2str(sum(isnan(anew(:)))) ])
disp(['Number of 0 = ', int2str(sum(find (anew(:) ==0))) ])

pause                               

%%
%
disp(' ')
disp('QUESTION 12: How many days of data does this data set represent?')
disp(' ')
%

disp(['# days: ', num2str(data(length(data(:,1)),1))])

pause

%%

disp(' ')
disp('QUESTION 13: How many data points of (time, lat, lon) are there in ')
disp('the cleaned up dataset?')
disp(' ')

disp(['# datapoints: ', int2str(length(data))])
