function [cellarray skater] = iceSkate(ice)
	[newca2 winner2] = iceSkate(ca2)


function [out winner] = iceSkate(ca)
    [row col] = size(ca);
    %finds the number of rows and columns
    scores = ca(2:end, 2:end);
    %the scores are not located in the first row or the first column
    nums = cellfun(@mean, scores);
    %averages each cell coontaining the scores
    ca(2:end, 2:end) = num2cell(nums);
    %turns the averaged scores back into a cell and replaces the originals
    ind = 2;
    %starts the index at 2
    len = length(ca);
    %finds the length of the cell array
    while ind <= len;
       event = ca(1, ind);
       if strcmp(event,'Short Program') == 1
               mat = cell2mat(ca(2:end, ind)); 
               adjusted = mat * 0.3;
               ca(2:end, ind) = num2cell(adjusted);
       elseif strcmp(event,'Long Program') == 1
               mat = cell2mat(ca(2:end, ind)); 
               adjusted = mat * 0.6;
               ca(2:end, ind) = num2cell(adjusted);
       else 
               mat = cell2mat(ca(2:end, ind)) ;
               adjusted = mat * 0.1;
               ca(2:end, ind) = num2cell(adjusted);
       end
       ind = ind + 1;
    end
    %adjusts the averaged score by the corresponding percentage
      
    ca(1,5) = {'Overall Score'};
    %creates a fifth column with header 'Overall Score'
    ind2 = 2;
    while ind2 <= row
        summed = ca{ind2, 2} + ca{ind2, 3} + ca{ind2, 4};
        ca(ind2, 5) = num2cell(summed);
        ind2 = ind2+1;
    end
    %sums the adjusted scores of each row and and it to the corresponding
    %row in the Overall Score column 
    overalls = cell2mat(ca(2:row, 5));
    %changes the overall scores to a matrix so the max can be found
    [maxOverall pos] = max(overalls);
    %outputs the position of the highest overall score
    winner = ca(pos + 1, 1);
    %one needs to be added to the position of the highest score to take
    %into account the row of headers
    %the names are in the first column
    out = ca;
end
% Function Name: iceSkate
% Inputs  (1): - (cell)   An N x 4 cell array representing ice skaters and 
%                         the scores given to them by three judges for each
%                         of three different events     
% Outputs (2): - (cell)   A cell array identical to the input cell array
%                         but with a column for overall scores appended
%              - (char)   The name of the skater with the highest overall
%                         score
%
% Function Description:
%   Write a function named "iceSkate" that takes in a cell array
%   representing a group of ice skaters and their scores in three events
%   and outputs the same cell array with a column appended showing each
%   skater's overall score. The function should also output the name of the
%   winning skater, that is, the skater with the highest overall score.
%
%   The input cell array will be given in the following format:
%   [{'Skater'}   {<Event1>}        {<Event2>}        {<Event3>}; 
%    {<Skater1>}  {<Score Vector>}  {<Score Vector>}  {<Score Vector>};
%    {<Skater2>}  {<Score Vector>}  {<Score Vector>}  {<Score Vector>}...]
%   
%   The three events are guaranteed to be the strings 'Short Program',
%   'Long Program', and 'Bonus Event', though they may appear in any order
%   in the second, third, and fourth columns. The skaters will be strings
%   representing the skaters' names. Finally, each score vector will
%   contain three double values, representing three judge's scores for a
%   given event. 
%
%   Each of the three judges scores for a given event are weighted equally
%   when determining a skater's average score for that event. However,the
%   scores for the three different events are weighted differently into a
%   skater's total score. In this function, the Short Program will be 
%   weighted 30% of a skater's overall score, the Long Program will be 
%   weighted 60%, and the Bonus Event will be weighted 10%.
% 
%   For example, consider the cell array:
%   [{'Skater'}  {'Long Program'}  {'Short Program'}  {'Bonus Event'};
%    {'Juliet'}  {[10, 9.5, 9]}    {[8, 9, 8.5]}      {[10, 10, 10]}]
%
%   Juliet's average scores for each event are 9.5, 8.5, and 10 for the
%   Long Program, Short Program, and Bonus Event, respectively. To
%   calculate her overall score, we can add:
%   9.5*0.6 + 8.5*0.3 + 10*0.1 = 9.25
%
%   All skaters' overall scores should be appended in a column titled
%   'Overall Score'.
%
%   Note:
%   -There may be any number of skaters.
%
%   Hint:
%   -You may find the function cell2mat() useful when determining the
%   winning skater.
%
% Test Cases:
%   ca1 = [{'Skater'}, {'Long Program'}, {'Short Program'}, {'Bonus Event'};...
%   {'Rachel'}, {[6 7 7]}, {[7 7 7.5]}, {[8.5 8 7.5]};...
%   {'Tara'}, {[9 8 7]}, {[8 8 8]}, {[9.5 9.5 8.5]};...
%   {'Anu'} {[10 10 9]}, {[9 9 8]}, {[4 5 5]}]
%
%  ca2 = [{'Skater'}, {'Bonus Event'}, {'Short Program'}, {'Long Program'};...
%   {'Nancy'}, {[10 7.5 8]}, {[8 9 9.5]}, {[8.5 8.5 8.5]};...
%   {'George'} {[10 8.5 9]}, {[9 9.5 8]}, {[10 10 10]}]
%
%	[newca1 winner1] = iceSkate(ca1)
%       newca1 => [{'Skater'}, {'Long Program'}, {'Short Program'},...
%                 {'Bonus Event'}, {'Overall Score'};...
%                 {'Rachel'}, {[6 7 7]}, {[7 7 7.5]}, {[8.5 8 7.5]} {6.95};...
%                 {'Tara'}, {[9 8 7]}, {[8 8 8]}, {[9.5 9.5 8.5]} {8.1167};...
%                 {'Anu'} {[10 10 9]}, {[9 9 8]}, {[4 5 5]} {8.8667}]
%       winner1 => 'Anu'
%
%	[newca2 winner2] = iceSkate(ca2)
%       newca2 => [{'Skater'}, {'Bonus Event'}, {'Short Program'},...
%                 {'Long Program'}, {'Overall Score'};...
%                 {'Nancy'}, {[10 7.5 8]}, {[8 9 9.5]}, {[8.5 8.5 8.5]}...
%                 {8.6};...
%                 {'George'} {[10 8.5 9]}, {[9 9.5 8]}, {[10 10 10]} {9.5667}]
%       winner2 => 'George'
