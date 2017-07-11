function howToCircle1(center,radius,angle) 
%plot the origin of circle
plot(center(1),center(2),'k*');
label1 = sprintf('center of circle: (%s,%s)',center(1),center(2));
hold on

%plot the circle centered around the origin
th = linspace(0,2*pi);
x = center(1)+(radius.*cos(th));
y = center(2)+(radius.*sin(th));
plot(x,y,'k')
label2 = 'circle perimeter';

x = center(1)+(radius.*cosd(angle));
y = center(2)+(radius.*sind(angle));
plot(x,y,'m*')
label3 = sprintf('(%g, %g)',x,y);

%plot radius line from center to point
plot([center(1),x],[center(2),y],'b')
label4 = sprintf('radius = %s',num2str(radius));

%plot horizontal line from origin to x component
plot([center(1),center(1)+(radius.*cosd(angle))],[center(2),center(2)],'g--')
label5 = 'r*cos(th)';

plot([center(1)+(radius.*cosd(angle)),center(1)+(radius.*cosd(angle))],[center(2),center(2)+(radius.*sind(angle))],'c--');
label6 = 'r*sin(th)';

%plot arc from horizontal line to radius line (1/3 length of horzontal
%line)
lengthHor = ((center(1)+(radius.*cosd(angle)))-center(1))./3;
th = linspace(0,angle); %plotting the arc
x = center(1)+lengthHor.*cosd(th); %center it around the origin
y = center(2)+lengthHor.*sind(th);
plot(x,y,'r--');
label7 = sprintf('th = %g degrees',angle);

%creates a legend using the labels created previously
legend(label1,label2,label3,label4,label5,label6,label7,'Location','SouthEast')

end
