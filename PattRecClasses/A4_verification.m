clc; clear all; close all;

%% finite test case
A       = [0.9 0.1 0;0 0.9 0.1];
q       = [1 0];
mc      = MarkovChain(q,A);

B(1)    = GaussD('Mean',0,'StDev',1);
B(2)    = GaussD('Mean',3,'StDev',2);

x   = [-0.2 2.6 1.3];
pX = prob(B,x);
hMM = [HMM(mc, B) ;HMM(mc, B)];

%c   = [1; 0.1625; 0.8266; 0.0581];

[alfaHat, c]=forward(mc,pX)
logprob(hMM,x)

%% infinite test case
clc; clear all; close all;

A       = [0.3 0.7 0;0 0.5 0.5; 0 0 0.1];
q       = [1;0;0];
mc      = MarkovChain(q,A);

B(1)    = DiscreteD([1 0 0 0]);
B(2)    = DiscreteD([0 0.5 0.4 0.1]);
B(3)    = DiscreteD([0.1 0.1 0.2 0.6]);

x   = [1 2 4 4 1];
%c   = [1; 0.35 ; 0.35; 79/140; 0.0994];

pX  = prob(B,x);
%pX = [1 0 0 0 1;0 0.5 0.1 0.1 0;0.1 0.1 0.6 0.6 0.1];
[alfaHat, c]=forward(mc,pX)
betaHat=backward(mc,pX,c)
