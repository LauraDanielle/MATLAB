function voteCounter(file)
fh = fopen(file);
open = fgetl(fh);
line = fgetl(fh);

peopleVec = {}; %initializes an empty cell for the while loop
countVec = {};
[people line] = strtok(line, char(10));
 new_name = sprintf('%s.txt',open);%creates new name for output file
 fh2 = fopen(new_name,'w');
while ischar(line)
[people line] = strtok(line, char(10));%looks at each name individually
i = 1;
while i <= length(peopleVec) & strcmp(people, peopleVec(i)) == 0
    i = i+1; %counter
end
if strcmp(line, '') == 0
    if i>length(peopleVec)
        peopleVec = [peopleVec; {people}]; %adds names to a cell array
        countVec = [countVec;  {1}]; %creates a counter for the cell array. Every time a name is not repeated, it adds one to new cell
    else
        countVec{i} = countVec{i} + 1; %adds one to original cell array
    end
end
   

line = fgetl(fh);
end 
i =1;
newNew = peopleVec{i};
new1 = num2str(countVec{i}); %concatenates together and print to the new text file
new_vec = [newNew,' ', new1]; %doesnot have new line character
fprintf(fh2,new_vec);
i = i+1;
while i<=length(peopleVec)
      fprintf(fh2, char(10)); %adds newline character for each beginning line, but not at the end of the line (gets rid of space at the bottom)
      newNew = peopleVec{i};
      
      new1 = num2str(countVec{i});
     
      new_vec = [newNew,' ', new1];
      fprintf(fh2,new_vec);
      i = i+1;
end

fclose(fh);
fclose(fh2);

end

% Function Name: voteCounter
% Inputs  (1): - (char) filename of votes
% Outputs (0): 
%
% Output files (1): - a text file containing the candidates and their
%                     tallied votes
%
% Function Description:
%   You use the brand new VoteMaster 3000 to tally up votes in the recent
%   elections of some of your extracurricular organizations. To your dismay,
%   it only outputs a txt file with a title describing the election and a
%   list of the candidates' names, with each line representing a vote for
%   that candidate.
% 
%   In addition to suing the VoteMaster 3000 makers for false advertising,
%   you now have to create a MATLAB function named voteCounter that takes in
%   the txt file of names and writes another txt file containing the
%   candidates and their respective votes, in descending order. Furthermore,
%   the filename of the written txt file should be the first line of the
%   input txt file.
% 
% For example, if the input txt file contained
% 
% ------------------------------
% 1371 Head TA Elections
% 
% McGraw
% Carter
% McGraw
% Bragg
% Carter
% ------------------------------
%
% Your written text file should be named "1371 Head TA Elections.txt" and 
% contain
% 
% ------------------------------
% McGraw 2
% Carter 2
% Bragg 1
% ------------------------------
% 
% Notes:
%   - In the written text file, there is a space between the candidate name
%   and his/her number of votes
%   - In the event of a tie, the candidate who appears first in the input
%   file wins (the sort function should take care of this)
%   - There should be no empty line at the end of your written file (i.e.
%   the last line of your written file should be the candidate who received
%   the least number of votes)
%   - Open the txt files in MATLAB to avoid confusion with new lines.
% 
% Test Cases:
%   voteCounter('list1.txt')
%       => Fight Club Elections 2014.txt should look like 
%               'Fight Club Elections 2014_sol.txt'
%   voteCounter('list2.txt')
%       => Glee Club Elections 2014.txt should look like 
%               'Glee Club Elections 2014_sol.txt'
% 
%==========================================================================
% PROBLEM 5. Clocks 'tick' me of....
%--------------------------------------------------------------------------
