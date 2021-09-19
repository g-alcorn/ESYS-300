%%
% ESYS 300 - Earth System Processes
% Laboratory #3
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
% 1- Read ASCII data
% 2- Preprocessing Data
% 3- Plotting (x-y and polar stereographic)
% 4- Writing/using functions
% 5- cellarray, structured array
%
%
% Laboratory #3: START HERE
%
% Spherical Velocity Program (SVP) (continued) 
% ============================================
%
% This Laboratory is the continuation of the Lab from the previous class.
% Except that we will now read the data directly from the raw "comma 
% separated" file that the buoy communicates via the iridum satellite to 
% the data-server in Halifax. We will then build on our own function to 
% reconstruct a Time variable that we can use for plotting using the Year, 
% Day, Hour, etc. variables that are standard output from the buoy. In a 
% second step we will use the cleaned postprocessed buoy data from last 
% class and we will plot the data on a polar stereographic projection.
%
% Optional: we will build our own function to calculate the buoy speed at
% each time step.
%
%

clear all, close all


%%
% Define path

flag = 'Student' ;
%flag = 'Bruno' ;
%flag = 'Firoza' ;

if strcmp(flag, 'Bruno')
    root    = ['/Users/brunotremblay/Dropbox/Teaching/ESYS-300/'] ; 
elseif strcmp(flag, 'Firoza')
    root    = [''] ;
elseif strcmp(flag, 'Student')
    root    = ['']                 % EDIT root with your credential.
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


%%
% Read the file "Lab3_SVP0070RF_raw.csv" on MyCourse.
% This file contains (among others) three variables (time, latitude, 
% longitude) from one of the buoys that we have deployed in the Canadian 
% Arctic Archipelago. The data is stored in "comma separated" format.
% NOTE: Do not use csvread or dmlread since it expects only numerical values
%
% Reading ASCII data using textscan:
% First open the file using "fid = fopen()"; fid = -1 means "file not
% found"
% In textscan, "1", means "read one line of data"
% ['delimiter', ','] means that the data is comma separated
% Help "textscan" will give you all possible format statements
% Try opening the file using a normal text editor. 
% If you succeed, the data is in ascii and textscan should be used. 
% If you dont, the data is in binary and fread (or load for .mat format) 
% should be used. 
%


filename = 'Lab3_SVP0070RF_raw.csv' ;

% Open file
% Generate fid 
csvPath = strcat('../data/',filename);
fid = fopen(csvPath);

% Read header (1 line of data) 
% Use textscan for the header row
% 16 cols with string labels
% HINT: Type YourVariableName{:} to see what is inside it.
headers = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',...
    1, 'delimiter', ',');

% Read data below header
% Use textscan for all rows below header
% 16 cols - 3 strings, 12 real numbers, 1 string
data = textscan(fid, '%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %s',...
    'HeaderLines', 1, 'delimiter', ',');
% DO NOT USE DATE TIMEd
% Close file
fclose(fid);

%
disp('QUESTION 1: Transform the Date tag into a Julian Day')

%
% Code a new function called Date2Jday.m that convert the time tag
% "DATA DATE (UTC)" into a JulianDay variable. 
% NOTE: You can use the variables YEAR, MONTH, DAY, etc. to check if your
% function is working correctly.
% This exercise will make you practice extracting strings from a 
% character variable.
%
% HINT: You may need the two lines of code below in your function. This
% gives you the Julian Day of the first day of each month.
% JdayFirstOfMonth = [1 32 61 92 122 153 183 214 245 275 306 336] ; 
% MonthJday = JdayFirstOfMonth(Month)' ; 

julianday = Date2Jday(vertcat(data(:,1)));         % [Complete the command]

[min(julianday), max(julianday), numel(julianday)]  % DO NOT delete

pause

disp('QUESTION 2: Plot the data using a projection that is centered')
disp('on the CAA using geoshow')

% Start from the cleaned-up version (end of previous assignment)
% stored in the file called Lab3_SVP0070RF_clean.mat on MyCourses
%
% Use https://www.mathworks.com/help/map/summary-and-guide-to-projections.html
% for a list of pojections supported by MATLAB.

% Load data

['type code here']

% plot using geoshow


['type code here']


