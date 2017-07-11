function cellarr = LLcsvread(filename)
file = filename(1:end-3);
new_name = sprintf('%stxt',file);
fh = fopen(new_name,'r');
line = fgetl(fh);
cellarr = {};
while ischar(line)
[word, line] = strtok(line,',');
cellarr = [cellarr {word}];

line = fget1(fh);

end

fclose(fh)
end
% Function Name: LLcsvread
% Inputs  (1): - (char) name of a csv file containing various data
% Outputs (1): - (cell) a cell array where each comma separated value
%                       is its own cell
%
% Function Description:
%   In MATLAB, we've learned the built-in csvread function, which reads in
%   numeric data from a comma separated value file and outputs the numeric
%   data in an array. However, csvread cannot handle files with non-numeric
%   data. So... Write a function called "LLcsvread" that will take in a .txt file
%   and return all the data from the file as strings in a cell array. 
%   Numbers may appear in the csv data, but they should be kept as strings.
%  
%
%   The layout of the data in the csv file should be preserved in the cell
%   array.  Data appearing on the second line of the csv file, for
%   instance, should appear in the second row of the cell array.  You may
%   need to use empty cells to complete a square cell array.
%
% Hints:
%   - The functions you learned in this course for operations with .txt
%     files may also be used with .csv files.
%
% Test Cases:
%   Use the included solution file to compare your own code's output to the
%   solution output for the following test cases:	
%
%   a = LLcsvread('csvTest1.csv')
%
%   b = LLcsv('csvTest2.csv')
%