function [probred,probgreen] = probability(bagred,baggreen,perred,pergreen)
rotten1 = bagred.*(perred./100); %lines 2&3 are percentages of bad apples
rotten2 = baggreen.*(pergreen./100);
total2 = bagred+baggreen;
probred = ((bagred-rotten1)./(total2)).*100;
probgreen = ((baggreen-rotten2)./(total2)).*100;
end