%%
% 
%  Homework 4
%  Laura Cox


%% Q1. Failing of Brazed Plate Heat Exchanger
load cycl.dat
cycles = cycl(:,1)*1000;
pressure = cycl(:,2);
censor = cycl(:,3);
%%% (a) Fit a CoxPH model with a baseline 0. Then, modify the baseline to
%%% get the estimators of survival functions for the three pressures. Plot
%%% the three survival estimators. Use MATLAB's coxphfit.

%%
% 
%  Testing different baselines from 0 - 6.5 Pa
% 


%% b = beta; H = cummulative hazard 
%%
% 
%  stats = 
%     covb: [2x2 double]
%     beta: [2x1 double]
%       se: [2x1 double]
%        z: [2x1 double]
%        p: [2x1 double]
% % 

[b_base,logL_base,H_base,stats_base] = coxphfit(pressure,cycles,'censoring',censor,'baseline',0);

[b_p1,logL_p1,H_p1,stats_p1] = coxphfit(pressure,cycles,...
  'censoring',censor,'baseline',4.5);

[b_p2,logL_p2,H_p2,stats_p2] = coxphfit(pressure,cycles,...
  'censoring',censor,'baseline',5.5);

[b_p3,logL_p3,H_p3,stats_p3] = coxphfit(pressure,cycles,...
  'censoring',censor,'baseline',6.5);

%%
% 
%  Derived from S = e^(-H(t))
% 

Sbaseline = exp(-H_base(:,2));  
Sp1   = exp(-H_p1(:,2));
Sp2  = exp(-H_p2(:,2)); 
Sp3  = exp(-H_p3(:,2)); 
% 
% %
figure(1)
%stairs(H_base(:,1),Sbaseline,'k-','linewidth',2)

stairs(H_base(:,1),Sp1,'b-','linewidth',2)
hold on
stairs(H_base(:,1),Sp2,'r-','linewidth',2)
stairs(H_base(:,1),Sp3,'g-','linewidth',2)

ylabel('$\hat S(t)$','Interpreter','LaTeX')
legend('Pressure 4.5','Pressure 5.5','Pressure 6.5', 'location','NE')
axis tight

hold off
%%% (b) Using MATLAB's module aftmodels from July 20th handout, fit the AFT
%%% with Weibull distribution for the three pressures. Report the
%%% parameters and plot the estimated survival curves.
addpath 'C:\Users\Laura\Documents\BMED4813\July20\aftmodels\'



[pars covpars SE CI Zscores pvalues gval exitflag]=aft(cycles,pressure,censor,'weibull');

z1 = 4.5;  z2=5.5; z3=6.5;
%%
% 
%  Pars represented the scale factors lambda, beta with lambda being the
%  second one
% 

scale1=exp(sum(pars(1:2)*z1));  
shape1=1/pars(2);    
tt=0:0.1:9;
plot(tt, 1-wblcdf(tt,scale1,shape1),'g-')

scale2=exp(sum(pars(1:2)*z2));  
shape2=1/pars(2) ;   
hold on
plot(tt, 1-wblcdf(tt,scale2,shape2),'r-')

scale3=exp(sum(pars(1:2)*z3));  
shape3=1/pars(2) ;   

plot(tt, 1-wblcdf(tt,scale2,shape2),'b-')

hold off


%% Q2. Performix Ultra Tubes
%%% (a) Using MATLAB fit the Weibull distribution to this data
load tubes.dat

data = tubes(:,1);
cens = tubes(:,2);
[th2,thCI2] = mle(data, 'distribution', 'weibull', 'censoring', cens);

tt = 1:0.2:350;
%%
% 
%  Plots KM estimator with confidence intervals (code for part b)
% 
[t2] = ple(data, cens);

%%
% 
%  Plots data fit to a weibull distribution.
% 

p1 = plot(tt, 1-wblcdf(tt, th2(1), th2(2)),'b-','linewidth',2);
hold on
%%% (b) Plot the KM estimator and superimpose the Weibull fit

%%
% 
%  See part A for code and graph
% 

%%% (c) The producer is setting the warranty limit so that within the
%%% warranty period replacement will be needed for no more than 20% of the
%%% tubes sold. Would the warranty of 70 kAs per tube be satisfactory from
%%% producer's standpoint?

%%
% 
%  Getting survival function at 70 KAs per tube gives a survival of 77.68 %
%  meaning that the warranty of 70KAs per tube would not be satisfactory as
%  it is greater than 20% failing.
% 

Survival_70Ka = 1-wblcdf(70, th2(1),th2(2));

%% Q3. Availability and Cost.
lambda = [.5 .2 .1 .25];
mu = [1 2 5 4];
states = [1, 2, 5];
A = [];
%%
% 
%  Use availability function here similar to how to survival function can
%  be plugged in to the structure function to get the probability of a
%  system working.
% 

syms e1 e2 e3 e4 t
for i = 1:length(lambda)
    Atemp = mu(i)./(lambda(i) + mu(i))   +  lambda(i)./(lambda(i) + mu(i)) .* exp(-(lambda(i) + mu(i)).* t );
    A = [A Atemp];
end
%%% (a) Is any wiring redundant here? What wire can be eliminated without
%%% affecting the functioning of the system?

%%
% 
%  The wire connecting component e1 to e4 is redundant. If component e1 is
%  functioning, it will choose the minimum path which is direct from e1 to
%  point B.

%%% (b) What is the probability that the system is available in times t =
%%% [1, 2, 5]

%%
% 
%  Same format for getting the structure function by taking the paths of
%  the system after the redundant wire was removed. The paths were found to
%  be P = {(e1),(e2,e4),(e3,e4)}
% 


temp_phi = expand(1-((1-e1)*(1-e2*e4)*(1-e3*e4)));
struc = subs(temp_phi, [e1^2, e2^2, e3^2, e4^2], [e1, e2, e3, e4]);
phi = subs(struc, [e1, e2, e3, e4], [A(1), A(2), A(3), A(4)]);

%%
% 
%  Availability at time t = 1 is 98.46%
% 

p_t1 = vpa(subs(phi, t, 1));

%%
% 
%  Availability at time t = 2 is 98.08%
% 

p_t2 = vpa(subs(phi, t, 2));

%%
% 
%  Availability at time t = 5 is 97.98%
% 

p_t5 = vpa(subs(phi, t, 5));
%%% (c) The loss per unit time when the system is down is $2000, and profit
%%% per unit of time when the system is up is $400. What is the long-term
%%% profit (or loss) per unit time of this system?
profit = 400;
cost = 2000;

%%
% 
%  Plug in large valve for time and evaluate availability at that time
% 

p_sysworks = vpa(subs(phi, t, 10000000000000));

%%
% 
%  Total cost = profit*(probability system works) - (cost*(probability
%  system fails)) = $351.60
% 

Total_Cost = profit*p_sysworks - (cost*(1-p_sysworks));

