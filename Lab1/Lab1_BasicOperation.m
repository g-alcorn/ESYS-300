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

GivenName   = ['Griffin'] ;                        % [ENTER given name]
FamilyName  = ['Alcorn'] ;                         % [ENTER family name]

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

%Define 3x5 matrix with values
Grade = [85, 85, 60 ; 75, 80, 75 ; 60, 75, 70 ; 65, 70, 80 ; 70, 65, 85];

disp("Year 1 Year 2 Year 3")
disp(Grade)

pause

%%
% b) You are not happy with the C's you have received in your BSc and
% decide to retake both courses. In both cases, your new mark is an A.
%

disp('QUESTION A2: Update and print new matrix of grades')

%Copy Grade then change specific items
UpdatedGrade = Grade;
UpdatedGrade(1,3) = 85; 
UpdatedGrade(3,1) = 85;

disp("Year 1 Year 2 Year 3")
disp(UpdatedGrade)

pause

%% 

disp('QUESTION A3: Print only the last two years of your new grades') 

%Create new array to output subset of Grade
ExcludeFirstYear = UpdatedGrade(:,2:3);

disp("Year 2 Year 3")
disp(ExcludeFirstYear)
pause

%%

disp('QUESTION A4: Calculate and print your Grade Point Average (GPA)') 
disp('for each individual year using the new grades')

%Create new array with grade point factors
GradePoints = [4, 4, 4; 3.3, 3.7, 3.3; 4, 3.3, 3; 2.7, 3, 3.7; 3, 2.7, 4];

%Calculate average for each year or column in array
GPA = [mean(GradePoints(:,1)), mean(GradePoints(:,2)), mean(GradePoints(:,3))];

disp("Year 1 Year 2 Year 3")
disp(GPA)
pause

%%

disp('QUESTION A5: Calculate and print the maximum grade for each year')
%max function automatically chooses best per column
BestPerYear = max(UpdatedGrade);

disp("Year 1 Year 2 Year 3")
disp(BestPerYear)

pause

%%

disp('Question A6: Calculate and print the CGPA (Cumulative GPA) using ')
disp('the new grades')

%Get number of rows and columns; calculate total credits earned
[RowCount, ColCount] = size(GradePoints);
CumulativeCredits = RowCount * ColCount;
CumulativePoints = 0;

%Loop through rows and cols of array; sum all values
for Row = 1:RowCount
    for Col = 1:ColCount
        CumulativePoints = CumulativePoints + GradePoints(Row,Col);
    end
end

%Divide cumulative grade points by number of credits
CGPA = CumulativePoints/CumulativeCredits;
disp("CGPA: ")
disp(CGPA)
pause

%%

disp('QUESTION A7: Sort the grades for each year in descending order')
disp('and print on screen')

%Built-in sort function
SortedGrade = sort(Grade,'descend');

disp("Year 1 Year 2 Year 3")
disp(SortedGrade)

pause

%%

disp('QUESTION A8: Calculate and print the sum of all numerical grades')
disp('for each year using a matrix multiplication (as opposed to the ')
disp(' command "sum"')

['type code here']

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

clear x count 

...                                     % [Initial condition for x]
...                                     % [Initial condition for x]

%for count ...                           % [Complete this line of code]
%    ...                                 % [Complete this line of code]
%end

...                                     % Print the 20th Fibonacci number

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
disp('do not include text)')
      
%  
%                 DATA |  Yr1  |  Yr2  |  Yr3  |
%   -------------------------------------------
%   Mean               |       |       |       |
%   -------------------------------------------
%   Standard Deviation |       |       |       |
%   -------------------------------------------
%   Variance           |       |       |       |
%   -------------------------------------------


['type code here']

pause

%%

disp('QUESTION C2: Plot the mean, standard deviation and variance ')
disp('of the matrix "Grade" (stored in M above) for each Year') 
 
% Use the command line to make the plot with different types of markers for 
% each variables and with a line linking the points. 
% Label the axes, give a title to the graph and include a legend.

['type code here']

pause

%%
% PART D: More operations
%

% The Grades above were entered in a vector rather than a matrix.
% 

disp('QUESTION D1: Calculate and print the grade point average for each year')
disp(' from the vector Grade using the command "reshape"') 

Grade = Grade(:) ;              % Same Grade as above but in a vector.
['type code here']              % GPA using reshape


disp('QUESTION D2: Extract and print the month from the date variable:') 

date = '01/07/1867' ;           % Creation of Canada

['type code here']              % Strip month


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

['Type your answer here using a string variable']

pause

%%

% Create the directory structure described above

disp('QUESTION E2: Go to the top directory [YourName] and list all ')
disp('sub-directories in the level below')

['Type your answer here']

pause

%%
disp('QUESTION E3: Go to the Lab1 sub-directory and list all ')
disp('sub-directories in the level below')

['Type your answer here']


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

%
x = [1 2 3] ;   
y = [1 2 3] ;
x * y               
pause               
%

disp('QUESTION F2:')
clear x
x(0) = 2 ;          
x(1) = 2 ;
sum(x)
pause


disp('QUESTION F3')
clear x
x(1) = 2 ; 
x(2) = 1 ;
Mean(x)             
pause





