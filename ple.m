function [table]=ple( times, censor, skipplot)
% USE
% alltimes =   [6 6 6 6 7 9 10 10  11 13 16 17 19 20 22 23 25 32 32 34 35];
%  censor =    [0 0 0 1 0 1   0  1    1    0    0    1   0   1   0    0  1    1    1   1   1];
%  ple(alltimes, censor)

if nargin < 3
    skipplot = 0;
end
  times=times(:)';   censor=censor(:)'; %make row vectors
 ncensor=sum(censor);
 observed = unique( times(censor==0));
 nobs=length(observed);
 totaln=length(times);
 max(times);
 % 
 atrisks=[totaln];
 for i = 1:nobs
   atrisk = totaln  -  sum( times < observed(i)  );
   atrisks =[atrisks atrisk];
 end
 
 failed=[0];
 for i = 1:nobs
   fail  = sum( times(censor==0) == observed(i)  );
   failed =[failed fail];
 end
 omh=1-failed./atrisks;
 s0 = cumprod(omh);
 s=[s0 s0(end)];
 s;
 [0 observed  max(times)];
 
  greenwood = s0.^2  .* [cumsum( failed./(atrisks .*( atrisks - failed)))];

  if (skipplot == 0)
%Plotting the \hat S(t)
fig=figure;
set(fig,'defaulttextinterpreter','latex');
 stairs([0 observed max(times)], [s],'k-','LineWidth',1)
  hold on
  stairs([0 observed  max(times)],   max(0, s  - 1.96 * sqrt([greenwood greenwood(end)])),'r:')

if(sum(censor)>0)
cens = unique(times(censor==1));  %unique censored times (for plot)
for i=1:length(cens)
    stimebegcen(i) = s(sum( observed <=  cens(i) )+1);
end
end

%if there are censored times, superimpose them on S(t)
if(sum(censor)>0)
    for j=1:length(cens)
   plot(cens(j), stimebegcen(j), 'ro',...
   'LineWidth',2,...
   'MarkerEdgeColor','k',...
                'MarkerFaceColor','r',...
                'MarkerSize',5)
    end
end
axis([0 max(times) 0 1.1])
xlabel('$t$'); ylabel('$\hat S(t)$')

%I = legend('$\hat S(t)$','$ 95\% CI $','Censored','Location','southwest') 
%set(I,'Interpreter','Latex');

  stairs([0 observed max(times)],   min(1, s  + 1.96 * sqrt([greenwood greenwood(end)])),'r:')
end

cens=  [-diff(atrisks)-failed(1:nobs) ncensor + ...
sum(diff(atrisks)) + sum(failed(1:nobs))];

table= [ [0 observed]' atrisks' failed' cens' omh' s(1:nobs+1)'];

