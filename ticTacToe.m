function ticTacToe(char_array)
plotTicTacToeGrid(2,2)
%plots the tic tac toe board centered around 2,2
hold on
i = 1;
%counter for each position in char array going down the columns
j = 0;
%counter for each position on the board (ie (1,2) (3,2))
while i<=9
   if j<=2
       a = 1; %columns
       b = 3-j; %rows
   elseif j>2 && j<=5
       a = 2;
       b = 6-j;
   elseif j>5 && j<=8
       a = 3;
       b = 9-j;
   end
   j = j+1;
    if strcmp(char_array(i),'O')==1 
        th = linspace(0,2*pi);
        x = a+(0.3).*cos(th); %positions circle around the center in each box
        y = b+(0.3).*sin(th);
        plot(x,y,'r')
    elseif strcmp(char_array(i),'X')==1
        plot([0.3+a,a-0.3],[0.3+b,b-0.3],'k') %plots two lines that are 0.6 long w/ origins at
        %each point in box (ie (1,2) etc)
        plot([a-0.3,a+0.3],[0.3+b,b-0.3],'k')
    end
    i = i+1;
end
winner = getWinner(char_array);
%creates title depending on winner of the game
if winner=='X'
    title('Player X wins!')
elseif winner=='O'
    title('Player O wins!')
elseif strcmpi(winner,'tie')==1
    title('Cat''s game.')
end
axis off
end
