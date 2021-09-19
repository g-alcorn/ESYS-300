function [julianday] = Date2Jday(dates)
%DATE2JDAY Converts cell array of date strings into array of Julian days
%   Input argument - dates
%       Cell array containing strings that describe date and time
%       Data in format 'yyyy-MM-dd hh:mm:ss'
%   Output argument - julianday
%       Array of Julian day values for each cell in dates
%       Each value is a decimal accounting for time

JdayFirstOfMonth = [1 32 60 91 121 152 182 213 244 274 305 335]; 
% Start 2013-04-29 2:30
% End 2015-08-11 12:30
% Must declare these outside scope of for-loops
lastIndex = length(dates{1});
answer = zeros(lastIndex,1);
yearCounter = 0;
yearDifference = 0;

% Reverse for-loop through input argument
% Calculate every jday individually
% Day value must subtract 1 in order to start at 0
% 48 measurements per day
for row = lastIndex:-1:1
    % Extract date information from string within cell within cell
    thisMonth = str2double(dates{1}{row}(6:7));
    thisDay = str2double(dates{1}{row}(9:10)) - 1;
    thisHour = str2double(dates{1}{row}(12:13));
    thisMinute = str2double(dates{1}{row}(15:16)) / 60;

    % Count new year if dataset is more than 1 year
    if thisDay == 0 && thisMonth == 1 && thisHour == 0 && thisMinute == 0
        yearCounter = yearCounter + 1;
    end

    % Determine offset based on number of years
    if yearCounter == 1
        yearDifference = 365;
    elseif yearCounter > 1
        yearDifference = 365 * yearCounter;
    end

    thisJday = JdayFirstOfMonth(thisMonth) + thisDay + (thisHour + thisMinute) / 24 + yearDifference;

    answer(lastIndex - row + 1) = thisJday;
end

% Return answer
julianday = answer;

end

