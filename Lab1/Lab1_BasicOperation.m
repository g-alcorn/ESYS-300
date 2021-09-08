%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% ESYS 300 - Investigating the Earth System
% Laboratory #1
%
% ********  READ CAREFULLY **************
%
% FOLLOW INSTRUCTION IN [] and READ ALL COMMENTS
%
% Upload your Laboratory on Dropbox by 12:00PM the day before next class.
%
% Only hand-in this m-file with your answers inserted in the program below.
% 
% NOTE:
%   ** I must be able to run your m.file without error messages
%   ** Only answers that are requested should be printed (use ; for
%      other intermediate steps).
%   ** If an error occurs in the code, I will stop correcting
%   ** If you cannot solve a question, write nothin so that the code
%      keep running.
%   
% Skill Tested:
% 1- Basic operations (find replace, subsampling, reshape, etc.); 
% 2- For loop
% 3- Basic statistics: mean, variance, standard deviation
% 4- Plotting data
%


% Always start your code by deleting all variables in the the workspace 
% and closing all figures 

clear all, close all


% Laboratory #1: START HERE
% -------------------------
% 
% NAME:      

GivenName   = 'Griffin' ;                        % [ENTER given name]
FamilyName  = 'Alcorn' ;                         % [ENTER family name]

disp('')
disp(['Name: ', GivenName, ' ', FamilyName])    % Print Full Name
disp('')


%
% PART A: Basic Matlab Commands - Matrices
%
%
% Your marks at the end of your three year Bachelors degree are:
% Year 1   Year 2    Year 3
%  A         A        C
%  B+        A-       B+
%  C         B+       B
%  B-        B        A-
%  B         B-       A
%

% a) Create and print on screen a matrix called "Grade" with the  
% numbers corresponding to the letter grade in the matrix above. 
% Use McGill conversion Table available online. 

%%
disp('QUESTION A1: Create and print your grade matrix on the screen')

% Define 5x3 matrix with values
Grade = [85, 85, 55 ; 75, 80, 75 ; 55, 75, 70 ; 65, 70, 80 ; 70, 65, 85];

disp("Year 1 Year 2 Year 3")
disp(Grade)

pause

%%
% b) You are not happy with the C's you have received in your BSc and
% decide to retake both courses. In both cases, your new mark is an A.
%

disp('QUESTION A2: Update and print new matrix of grades')

% Change specific items within Grade
Grade(1, 3) = 85; 
Grade(3, 1) = 85;

disp("Year 1 Year 2 Year 3")
disp(Grade)

pause

%% 

disp('QUESTION A3: Print only the last two years of your new grades') 

disp("Year 2 Year 3")
disp(Grade(:, 2:3))

pause

%%

disp('QUESTION A4: Calculate and print your Grade Point Average (GPA)') 
disp('for each individual year using the new grades')

% Create new array with grade point factors
GradePoints = [4, 4, 4; 3.3, 3.7, 3.3; 4, 3.3, 3; 2.7, 3, 3.7; 3, 2.7, 4];
GPA = [mean(GradePoints(:, 1)), mean(GradePoints(:, 2)), mean(GradePoints(:, 3))];

disp("4.0 GPA scale")
disp("Year 1 Year 2 Year 3")
disp(GPA)

GPA = [mean(Grade(:, 1)), mean(Grade(:, 2)), mean(Grade(:, 3))];

disp("100 GPA scale")
disp("Year 1 Year 2 Year 3")
disp(GPA)

pause

%%

disp('QUESTION A5: Calculate and print the maximum grade for each year')

% max function automatically chooses best per column
disp("Year 1 Year 2 Year 3")
disp(max(Grade))

pause

%%

disp('Question A6: Calculate and print the CGPA (Cumulative GPA) using ')
disp('the new grades')

% Get number of rows and columns; calculate total credits earned
[RowCount, ColCount] = size(GradePoints);
CumulativeCredits = RowCount * ColCount;
CumulativePoints = 0;

% Loop through rows and cols of array; sum all values
for Row = 1:RowCount
    for Col = 1:ColCount
        CumulativePoints = CumulativePoints + GradePoints(Row, Col);
    end
end

% Divide cumulative grade points by number of credits
CGPA = CumulativePoints / CumulativeCredits;
disp("4.0 GPA scale")
disp("CGPA: " + CGPA + newline)

CGPA = sum(sum(Grade)) / CumulativeCredits
disp("100 GPA scale")
disp("CGPA: " + CGPA + newline)

pause

%%

disp('QUESTION A7: Sort the grades for each year in descending order')
disp('and print on screen')

% Built-in sort function
disp("Year 1 Year 2 Year 3")
disp(sort(Grade, "descend"))

pause

%%

disp('QUESTION A8: Calculate and print the sum of all numerical grades')
disp('for each year using a matrix multiplication (as opposed to the ')
disp(' command "sum")')

SimpleSum = sum(sum(Grade));

disp("Sum calculated with sum commands: " + SimpleSum + newline)

pause


%%
% Part B: for loop - Repetitive Tasks
% -----------------------------------

% In the Fibonacci sequence of numbers, each number is the sum of the 
% previous two numbers, starting with 0 and 1. 

%
disp('QUESTION B1: Calculate the Fibonacci time series for the')
disp('first 20 numbers by completing the code below.')
disp('Print the 20th Fibonacci number in the series.')

clear fib count 

% Initialize fib, an array of length 20 which will later contain Fibonacci sequence
% fib initially starts at 0 and increases by steps of 1 
% in order to properly set first two steps of sequence
fib = (0:1:19);

% iterate through fib starting at 3rd element
% set each element to actual value of sequence - the sum of prior 2 elements
for count = 3:20
    fib(count) = fib(count - 1) + fib(count - 2);
end

% Print the 20th Fibonacci number
disp(fib(20))

pause


%%
%  
% Part C - Plotting
% -----------------
% 

%
disp('QUESTION C1: Calculate and print the mean (GPA), standard ')
disp('deviation and variance of the matrix Grade above.')
disp('Store the data in a variable called M')
disp('The data in the matrix M should have the following structure')
disp('(do not include text)')
      
%  
%                 DATA |  Yr1  |  Yr2  |  Yr3  |
%   -------------------------------------------
%   Mean               |       |       |       |
%   -------------------------------------------
%   Standard Deviation |       |       |       |
%   -------------------------------------------
%   Variance           |       |       |       |
%   -------------------------------------------


M = [3, 3];
for i = 1:3
    for j = 1:3
        if i == 1
            M(i ,j) = mean(Grade(:, j));
            
        elseif i == 2
            M(i, j) = std(Grade(:, j));
            
        elseif i == 3
            M(i, j) = var(Grade(:, j));
            
        end
    end
end

disp(M)

pause

%%

disp('QUESTION C2: Plot the mean, standard deviation and variance ')
disp('of the matrix "Grade" (stored in M above) for each Year') 
 
% Use the command line to make the plot with different types of markers for 
% each variables and with a line linking the points. 
% Label the axes, give a title to the graph and include a legend.

M_transposed = transpose(M);

p = plot(M_transposed);
p(1).Marker = "^";
p(1).MarkerFaceColor = "b";
p(2).Marker = "v";
p(2).MarkerFaceColor = "#D95319";
p(3).Marker = "s";
p(3).MarkerFaceColor = "#EDB120";

title("Grades analysis");
xlabel("Year");
xticks([1, 2, 3]);
ylabel("Values");
ylim([0,100]);
yticks([0:10:100]);

legend("Mean", "Standard deviation", "Variance", "Location", "eastoutside")
disp("Plot loaded.")

pause

%%
% PART D: More operations
%

% The Grades above were entered in a vector rather than a matrix.
% 

disp('QUESTION D1: Calculate and print the grade point average for each year')
disp(' from the vector Grade using the command "reshape"') 

% Reshape both Grade and GradePoints
% Converts matrix into vector (single column structure)
CGPA = sum(GradePoints(:))/CumulativeCredits;
disp("4.0 CGPA scale")
disp(CGPA)

CGPA = sum(Grade(:))/CumulativeCredits;
disp("100 CGPA scale")
disp(CGPA)

pause

disp('QUESTION D2: Extract and print the month from the date variable:') 

% Creation of Canada
date = '01/07/1867';

t = datetime(date, "InputFormat", "dd/MM/yyyy");
disp("Month: " + t.Month + newline)

pause

%%  
% Part E - Directory Structure and Navigating Directories
% -------------------------------------------------------
% 

% In this part of the laboratory, you will set up your directory structure
% or tree that will be used in all future laboratories. This will give you 
% practice on how to create and navigate directories.
%
% There will be 6 laboratories (or directories) in the first part of the 
% course called Lab1, Lab2, etc. In each laboratories, you will have three 
% sub-directories where you store your program, data and plots (called 
% "matfiles", "data", "plots", respectively.
%
% Use the commands documented in BasicMatlabCommands.docx

%

disp('QUESTION E1: How many levels does your directory tree should have?') 
disp('Where level 1 is your own directory ([FirstLast]')

e1answer = "Three levels. Level 1 - named directory, Level 2 - LabX directory," + newline + "Level 3 - subdirectories for matfiles, data, and plots" 

pause

%%

% Create the directory structure described above

disp('QUESTION E2: Go to the top directory [YourName] and list all ')
disp('sub-directories in the level below')

command1 = "cd ESYS-300/GriffinAlcorn"
command2 = "ls"

pause

%%
disp('QUESTION E3: Go to the Lab1 sub-directory and list all ')
disp('sub-directories in the level below')

command1 = "cd Lab1"
command2 = "ls"

pause


%%
%  
% Part F - Debugging Code
% ----------------------
% 

% In this part of the laboratory, you will practice debugging codes
%
% Use the document DebuggingCodes.m for help
%
% Correct the bugs in the command lines below. 
% I.e. The code should run to the end once corrected.
%

disp('QUESTION F1:')

% * operation changed to .* to do itemwise multiplication
x = [1 2 3];
y = [1 2 3];
x .* y

pause

disp('QUESTION F2:')

% Indices increased by 1 because index of 0 is illegal
clear x
x(1) = 2 ;
x(2) = 2 ;
sum(x)

pause

disp('QUESTION F3')

% Mean(x) changed to mean(x) - function names are case sensitive 
clear x
x(1) = 2 ;
x(2) = 1 ;
mean(x)

pause