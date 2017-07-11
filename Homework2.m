%% 
%  HOMEWORK 2
%  Laura Cox BMED 4813
%% 1. Pacemaker System Longevity
% 

%%% (a) Assume that the time to replacement, T, of the device with high impedance venticular
% leads is normally distributed with mean mu = 96 months, and standard deviation sigma = 10
% months.
% (i) What is the probability that T is less than 7 years? 
    prob_lessthan7 = normcdf(84, 96, 10);
%%
% 
%  The probability was found to be 0.1151 that replacement time is less
%  than 7 years for the batteries. Normal distribution is continuous so
%  you can include 7 years in your calculation unlike a discrete
%  distribution like a binomial function because the change in probability 
%  is extremely small between 7 years and 6.999 years etc. Time period,
%  mean and standard deviation were reported in months for the CDF 
%  function.
% 
% (ii) What is the probability that T exceeds 10 years?
    prob_exceed10 = 1- normcdf(120, 96, 10);

%%
% 
%  The probability was found to be 0.0082 that replacement time is greater
%  than 10 years for the batteries. You subtract your CDF from 1 to account
%  for the probability above 10 years (normcdf finds the probability to the
%  left of the chosen time point). Again, the time period, mean and
%  standard deviations were reported in months.
% 

% (iii) For what T* 98 percent of devices will have replacement time exceeding T*?
    t_star = norminv(0.02, 96, 10);

%%
% 
%  The time in which 98 percent of devices will need to be replaced was found to
%  be 75.4625 months, or 6.2885 years. You want to find the time that only
%  2 % of devices is functional, which is why you choose that as the sectio
%  of the function to evaluate. Mean and standard deviation were reported
%  in months again. 
% 


%%% (b) Design sample size [pages 438-440] for this experiment if (look at
%   formula)
% (i) the attrition rate is 50 percent; (expect half patients to drop out)
% (ii) clinically significant difference between the population means that we want to control
% is 6 months;
% (iii) both populations have equal standard deviation of  = 10 months;
% (iv) significance testing should be done at alpha = 5 percent level; and
% (v) desired power is 1 -beta = 90 percent. (anymore will give huge sample size
% and give difference in battery life of 7 days is very significant)

s1 = 10;
s2 = 10;
delta = 6; % H1: u1-u2
sig = 1 - .05;
power = .9;
ssize = 2*((s1^2 + s2^2)*(norminv(sig)+norminv(power))^2/(delta^2));

%%
% 
%  The sample size was found to be 96 for this experiment when accounting
%  for the attrition (drop out) rate of 50 percent. 
% 

%%% (c) Confirm that the test H0 : uL = uH versus H1 : uL < uH is indeed
%%% not significant at 5 percent significance level, as the authors report. Calculate the p-value.
% 
v1 = 6.8^2;
v2 = 10.3^2;
n1 = 10;
n2 = 6;
x1 = 86.7;
x2 = 91.2;


df = (v1/n1 + v2/n2)^2/((v1/n1)^2/(n1-1) + (v2/n2)^2/(n2-1));
t = (x1 - x2)/sqrt((v1/n1 + v2/n2));
prob_attrition = tcdf(t,df);
%%
% 
%  The probability that uL < uH is p = 0.1849 making the data not
%  signficant as reported by the authors. 
% 


% What would happen if the sample means and standard deviations remained the same,
% but there was no attrition, that is, the number of patients stayed 20+20, as at the beginning
% of the study.
n1 = 20;
n2 = 20;

df2 = (v1/n1 + v2/n2)^2/((v1/n1)^2/(n1-1) + (v2/n2)^2/(n2-1));
t1 = (x1 - x2)/sqrt((v1/n1 + v2/n2));
prob_noattrition = tcdf(t1,df2);


%%
% 
%  The probability would have been p = 0.0563 which is a small change from the
%  probability found when there was a 50 percent attrition rate, which means that
%  there is still no significance in this data set. 
% 


%% 2. Batteries for Medical Carts

%%% (a) For the regime Three full charge & discharge per day, 70 percent of batteries need re-
% placement by the time t = 10 years. Using this information estimate the rate lamda for this
% regime. What is the median service time? At what time 95 percent of carts will have the batteries
% replaced? 
lambda_exp = - log(0.3)/10;

% Median Service Time (assume 50 percent of batteries are dead)
% 
t_50 = expinv(0.5, 1/lambda_exp);
% t_50a = - log(0.5)/lambda_exp;

t_95 = expinv(0.95, 1/lambda_exp);

% t_95a = - log(0.05)/lambda_exp;

%%
% 
%  The lambda for the exponetial distribution was found to be 0.1204 by
%  solving for lambda when S = .3 = 1 - F(t). The same logic was used to
%  find the time when 50 percent batteries weren't working and 95 percent weren't
%  working. The times were found to be 5.7572 years and 24.8821 years for
%  50 and 95 percent respectively. In this case, matlab had a built in
%  function for the exponetial distribution that mimicks the survival
%  function which is why expinv was used.
% 




%%% (b) Why the exponential distribution may not be a good model for the time to EOL?
% good for something that does not age - batteries age though
% Repeat (a) using Weibull distribution with parameter gamma = 3/2. (Hint: Weibull CDF in this
% case is F(t) = 1 - e^(-lamda*t^3/2), lamda > 0.) 
lambda_weib = -log(.3)/(10^(3/2));

% S = .5 = 1 - F(10)
weib_50 = (-log(0.5)/lambda_weib)^(2/3);

weib_95 = (-log(0.05)/lambda_weib)^(2/3);

%%
% 
%  The lambda for the Weibull distribution was found to be 0.0381 by
%  setting S = 0.3 = 1 - F(t) for the Weibull distribution. The years that
%  50 snd 95 percent needed to be replaces were 6.9205 and 18.3622
%  respectively. Since there is not a built in function you must solve for
%  time by setting S = 0.3 = 1 - F(t).
% 


%% 3. Galileo versus Ortho.


total_samples = 2229;
both_positive = 78; %for automated systems Ortho and Immucor
immucor_only = 18;
ortho_only = 11; 
%%% (a) Form a paired 2×2 table. Find risk difference RD, risk ratio RR, and odds ratio OR.

%%% (b) Find 95% CIs for RD, RR and OR. Show that 0 belongs to CI for RD and 1 belongs
% to CI’s for RR and OR, thus indicating that there is no significant difference between the
% risks. For (a) and (b) you can use MATLAB code mcnemar.m from the text repository.

%%
% 
% <<texttable.PNG>>
% 
%%
% 
%  Above is the paired table used to find risk for having a positive test.
% 

%%
% 
% <<mytable.PNG>>
% 
%%
% 
%  Above is the table actually used for analysis. Sum of 2x2 should be
%  2229.
% 

paired = [78 11; 18 2122];

%%
% Below is how you would calculate the populations for diseased and not
% diseased as well as calculating the risk differene, ratio and odd ratio.
% p1 = paired(1,1)/(paired(1,1)+paired(1,2));
% p2 = paired(2,1)/(paired(2,1)+paired(2,2));
% RD = p1- p2;
% RR = p1/p2;
% OR = (p1/(1-p1))/(p2/(1-p2));

%%
%  Below are the results from running the McNamara function. Risk
%  difference was -0.0031 with CI of [-0.0190 0.0127] which includes 0. The
%  risk ratio was 0.9271 with CI of [0.8270 1.0392] which includes 1. The
%  odds ratio was 0.6111 with CI of [0.2570 1.4533] which includes 1.
%  N: 2229
%  chi2: 1.6897
%  pval: 0.1936
%  h: 0
%  p1: 0.0399
%  p2: 0.0431
%  rd: -0.0031
%  rdint: [-0.0190 0.0127]
%  rr: 0.9271
%  rrint: [0.8270 1.0392]
%  or: 0.6111
%  ormintmiet: [0.2570 1.4533]
%  orrgb: [0.2886 1.2938]
%  orliddell: [0.2608 1.3663]
% 


[stats_Mc] = mcnemart(paired, 0.05);
%%% (c) Compare the risks using Liddell’s procedure which is exact. You can find Liddell’s
% procedure in the text (page 622).
liddell(paired);

%%
% 
% Liddell's exact test results can be found below with a relative risk of
% 1.6364. The CI at 95 percent confidence was [0.7319 3.8340] which still
% includes 1 making this equivalent with McNamara.


%%% (d) If you are to design similar study, what sample size would you need so that a 5 percent-
% level test finds discrepancy p12 - p21 = delta, for Miettinen’s formula (page 621) with w = 4 percent,
% delta = 1 percent and power of 85 percent
beta = .15;
w = 0.04;
delta = 0.01;
alpha = 0.05;
ssmn = (norminv(1-alpha)*sqrt(w)+norminv(1-beta)*sqrt(w - delta^2*(3 + w)/(4*w)) )^2/delta^2;
%%
% The sample size was found to be 2823 using Miettinen's formula.

