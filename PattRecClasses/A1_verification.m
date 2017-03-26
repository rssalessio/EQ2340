clc; clear all; close all;

%% 1
q       = [0.75;0.25];
A       = [0.99 0.01;0.03 0.97];
B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',3,'StDev',2);
[S,T]   = eig(A.');

%% 2
mc      = MarkovChain(q,A);
sec1    = rand(mc,10000);
hist1   = hist(sec1,[1,2]);
pGuess  = hist1/sum(hist1);

%% 3 - do mathematical derivation again
hHMM    = HMM(mc,B);
X       = rand(hHMM,10000);
mean1   = mean(X);
var1    = var(X);

%% 4 pretty obvious, that the HMM generates a series, where it is likely, that 
% S_t+1 is in the same state as S_t since the probabilities are high (0.99
% and 0.97). There the HMM kind of switches from rapidly from one to another
% gaussian and stays within this gaussian for a while - it's easier to
% estimate to which source the state belongs
X       = rand(hHMM,500);
figure(1)
plot(X)
xlabel('Time in seconds [t]')
ylabel('Output of the HMM [X_t]')
title('Time history of the HMM')

%% 5 Difference: No jumps, but the variance (fluctuation is nearly the same)
% Is it possible to estimate? Normally yes... signals that are far away
% from zero are more likely to belong to 2 (larger variance)
clc; clear all; close all;

q       = [0.75;0.25];
A       = [0.99 0.01;0.03 0.97];
B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',0,'StDev',2);
mc      = MarkovChain(q,A);
hHMM    = HMM(mc,B);

X       = rand(hHMM,500);
figure(1)
plot(X)
xlabel('Time in seconds [t]')
ylabel('Output of the HMM [X_t]')
title('Time history of the HMM')

%% 6 
clc; clear all; close all;

q       = [0.33; 0.33; 0.33];
A_finite =[0.3 0.4 0.2 0.1; 0.4 0.3 0.4 0;0.1 0.3 0.4 0.2];
B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',0,'StDev',2);
B(3)    = GaussD('Mean',0,'StDev',3);
mc      = MarkovChain(q,A_finite);
hHMM    = HMM(mc,B);
X       = rand(hHMM,500);
figure(1)
plot(X)
xlabel('Time in seconds [t]')
ylabel('Output of the HMM [X_t]')
title('Time history of the HMM')

%% 7
clc; clear all; close all;

% random
% q       = [0.75;0.25];
% A       = [0.99 0.01;0.03 0.97];
% B(1)    = DiscreteD([3 3]);
% B(2)    = DiscreteD([3 3]);
% mc      = MarkovChain(q,A);
% hHMM    = HMM(mc,B);
% X       = rand(hHMM,500);
% figure(1)
% plot(X)
% xlabel('Time in seconds [t]')
% ylabel('Output of the HMM [X_t]')
% title('Time history of the HMM')

% vector with diagonal covariance
% q       = [0.75;0.25];
% A       = [0.99 0.01;0.03 0.97];
% B(1)    = GaussD('Mean',[0 5],'StDev',[3 1]);
% B(2)    = GaussD('Mean',[50 55],'StDev',[1 1]);
% mc      = MarkovChain(q,A);
% hHMM    = HMM(mc,B);
% X       = rand(hHMM,500);
% figure(1)
% plot(X(1,:))
% hold on
% plot(X(2,:),'r')
% legend('feat1','feat2')
% xlabel('Time in seconds [s]')
% ylabel('Feature')

% vector with non diagonal covariance
q       = [0.75;0.25];
A       = [0.99 0.01;0.03 0.97];
B(1)    = GaussD('Mean',[0 50],'Covariance',[2 1;1 4]);
B(2)    = GaussD('Mean',[10 55],'StDev',[1 1]);
mc      = MarkovChain(q,A);
hHMM    = HMM(mc,B);
X       = rand(hHMM,500);
figure(1)
plot(X(1,:))
hold on
plot(X(2,:),'r')
legend('feat1','feat2')
xlabel('Time in seconds [s]')
ylabel('Feature')