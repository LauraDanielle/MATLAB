function [log_free char_free timeslots] = schedulizer(name,span,day)
[num txt raw] = xlsread(name);
times = raw(2:end-1,1);
days = raw(1,2:end);
[time1 time2] = strtok(span,'-');
[time1 period1] = strtok(time1,'a.m./p.m.');
[time2 period2] = strtok(time2(3:end),'a.m./p.m.');
number = floor(str2num(time1));
number1 = floor(str2num(time2));
switch day
    case 'Monday'
        activities = raw(2:end-1,2)
    case 'Tuesday'
        activities = raw(2:end-1,3)
    case 'Wednesday'
        activities = raw(2:end-1,4)
    case 'Thursday'
        activities = raw(2:end-1,5)
    case 'Friday'
        activities = raw(2:end-1,6)
    case 'Saturday'
        activities = raw(2:end-1,7)
    case 'Sunday'
        activities = raw(2:end-1,8)
end
none_number = [];
i = 1;
while i<=length(activities)
places = isnan(activities{i});
none_number = [none_number places];
i = i+1;
end
position1 = 

% PROBLEM 5. Clocks 'tick' me of....
%--------------------------------------------------------------------------
% Function Name: schedulizer 
% Inputs  (3): - (char) the name of an excel file
%              - (char) the time span you need to check for
%              - (char) the day you need to check for
% Outputs (3): - (log) a logical which says if you're free or not
%              - (char) an output which says if you're free or if not.
%              - (cell) a cell array either diplaying 'None' or your busy 
%                       timeslots and what you'd be doing then. 
%                       
% Function Description:
%   You are an extremely busy student and find managing time a huge pain at 
%   Georgia Tech. You're never able to keep tabs on what you have to do and
%   when you have to do it. You almost wished you had a personal assistant 
%   who kept your time. That, you can't afford(as of now). But what you can 
%   afford to do is write a MATLAB program to do so (the joy!). 
%   Write a function that takes in a timetable and finds out whether you'd  
%   be free in a given time slot. 
%   If you are free in all of the time slots, it should output : 
%       - A true logical output
%       - An output string saying 'Free in all slots'
%       - An output cell saying 'None' 
%   If you aren't free in all of the time slots, it should output :
%       - A false logical output
%       - An output string 'Not Free'                                    
%       - An output cell ARRAY with the timeslots you're busy in the
%       first column and what you're doing in the second column.
% Notes:
%   - The first line of the timetable will be days and first column will
%   always be time.
%   - The time will always have a one hour slot on the time table.         
%   - Time slots aren't inclusive. If you are asked to check from 5 a.m. 
%     7 a.m. , you will check for time slots 5 a.m. and 6 a.m. on the time 
%   table.
%   E.g. : The time Table looks like:
%                'Monday'       'Tuesday
%   '5 a.m.'     'Jog'          'Sleep'                
%   '6 a.m.'     'Sleep'        'Sleep'                
%   '7 a.m.'     'Eat'          'Sleep'  
%   If we ask you to check what you're doing on Monday from 5 a.m. - 7 a.m,
%   it should check for only the cell corresponding to 5 a.m. and 6 a.m.
%   - If we give you a timeslot which starts from the middle of one hour to
%   the middle of the other, check for the entire timeslot of each of the
%   hours. Eg. If given time range is 7:30 - 9:15, you will check for 7 -
%   10.
%   - The time on the timetable is of the format : <hr><space><a.m./p.m.>
%   eg: '7 p.m.' or '10 a.m.'. On the other hand the time given in the test
%   cases will be <hr>:<minutes><space><a.m./p.m.>. You want to keep that
%   in mind.
%
%  Hints:
%  - strcmp() might come to use. Just maybe. (*wink*)
%  - You might want to look at the excel file before you start coding.
% 
% Test Cases:
%   file = 'Timetable.xlsx'
%   timespan1 = '9:00 p.m. - 12:00 a.m.'
%   day1 = 'Thursday'
%   [log1, out1, busySlots1 ] = schedulizer(file, timespan1 , day1);
%       log1 => true
%       out1 => 'Free in all slots'
%       busySlots1 => 'None'
%
%
%   file = 'Timetable.xlsx'
%   timespan2 = '7:00 a.m. - 10:00 a.m.'
%   day2 = 'Monday'
%   [log2, out2, busySlots2 ] = schedulizer(file, timespan2 , day2);
%       log2 => true
%       out2 => 'Free in all slots'
%       busySlots2 => 'None'
%
%
%   file = 'Timetable.xlsx'
%   timespan3 = '10:00 p.m. - 12:15 a.m.'
%   day3 = 'Friday'
%   [log3, out3, busySlots3 ] = schedulizer(file, timespan3 , day3);
%       log3 => false
%       out3 => 'Not free'
%       busySlots3 =>     '10 p.m.'    'Cs1371 Hw'                  
%                         '11 p.m.'    'Cs1371 Hw'                  
%                         '12 a.m.'    'Post submission celebration'
%==============================