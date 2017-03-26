clc; clear all; close all;

%% 1
q       = [0.75;0.25];
A       = [0.99, 0.01; 0.03, 0.97];
B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',3,'StDev',2);
mc      = MarkovChain(q,A);
N       = 1e4;


seq     = rand(mc, N);
freqs   = hist(seq,unique(seq))./N;
disp(['Frequencies: ', num2str(freqs)]);


%%2
hMM     = HMM(mc, B);
seq     = rand(hMM, N);
mu      = mean(seq);
sigmasq = var(seq);
disp(['Mean: ', num2str(mu), ' - Variance: ', num2str(sigmasq)]);


%% 3
N=500;
figure;
X   = rand(hMM,N);
plot(X);
xlabel('Time [s]'); grid;
ylabel('X_t');
title('HMM - Time Series');
isWhite(X',0.1,1,'plot','test');

%%
B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',0,'StDev',2);
hMM    = HMM(mc,B);

X       = rand(hMM,N);
figure;
plot(X); 
xlabel('Time [s]'); grid;
ylabel('X_t');
title('HMM - Time Series');
isWhite(X',0.1,1,'plot','test');


%% 6 
q       = [0.75;0.25];
A       = [0.3, 0.1, 0.6; 0.1, 0.3, 0.6];
B(1)    = GaussD('Mean',1,'StDev',1);
B(2)    = GaussD('Mean',10,'StDev',2);
mc      = MarkovChain(q,A);
hHMM    = HMM(mc,B);
X       = rand(hHMM,500);
figure;
plot(X); 
xlabel('Time [s]'); grid;
ylabel('X_t');
title('HMM - Time Series');
%%
q       = [0.75;0.25];
A       = [0.99 0.01;0.03 0.97];
B(1)    = GaussD('Mean',[0 30],'Covariance',[2 1;1 4]);
B(2)    = GaussD('Mean',[10 55],'StDev',[1 1]);
mc      = MarkovChain(q,A);
hHMM    = HMM(mc,B);
X       = rand(hHMM,500);
figure;
plot(X(1,:)) ;hold on; plot(X(2,:),'r') ;
legend('Feature 1','Feature 2');
xlabel('Time[s]');
ylabel('Features'); grid;
