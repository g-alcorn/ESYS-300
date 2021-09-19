function [julianday] = Date2Jday(dates)
%DATE2JDAY Summary of this function goes here
%   Detailed explanation goes here

JdayFirstOfMonth = [1 32 60 91 121 152 182 213 244 274 305 335]; 
% Start 2013-04-29 2:30
% End 2015-08-11 12:30
firstIndex = length(dates);

lastYear = dates{1}(1:4);
lastMonth = dates{1}(6:7);
lastDay = dates{1}(9:10);
lastTime = dates{1}(12:19);

firstYear = dates{firstIndex}(1:4);
firstMonth = dates{firstIndex}(6:7);
firstDay = dates{firstIndex}(9:10);
firstTime = dates{firstIndex}(12:19);

% dateTimeStr = split(dates{1}, ' ');
% dateStr = split(dateTimeStr(:,1), '-');
% timeStr = split(dateTimeStr(:,2), ':');

% length = numel(dateStr)/3;
% YearJDay = 365 * (str2double(dateStr{1,1,1}) - 2013);
% MonthJDay = JdayFirstOfMonth(str2double(dateStr{1,2,1}));


% jdayStart = JdayFirstOfMonth(str2num(dateStr{39545,2}))...
%    + str2num(dateStr{39545,3});

% Set julianday = answer

end

