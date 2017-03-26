function [alfaHat, c]=forward(mc,pX)
%[alfaHat, c]=forward(mc,pX)
%calculates state and observation probabilities for one single data sequence,
%using the forward algorithm, for a given single MarkovChain object,
%to be used when the MarkovChain is included in a HMM object.
%
%Input:
%mc= single MarkovChain object
%pX= matrix with state-conditional likelihood values,
%   without considering the Markov depencence between sequence samples.
%	pX(j,t)= myScale(t)* P( X(t)= observed x(t) | S(t)= j ); j=1..N; t=1..T
%	(must be pre-calculated externally)
%NOTE: pX may be arbitrarily scaled, as defined externally,
%   i.e., pX may not be a properly normalized probability density or mass.
%
%NOTE: If the HMM has Finite Duration, it is assumed to have reached the end
%after the last data element in the given sequence, i.e. S(T+1)=END=N+1.
%
%Result:
%alfaHat=matrix with normalized state probabilities, given the observations:
%	alfaHat(j,t)=P[S(t)=j|x(1)...x(t), HMM]; t=1..T
%c=row vector with observation probabilities, given the HMM:
%	c(t)=P[x(t) | x(1)...x(t-1),HMM]; t=1..T
%	c(1)*c(2)*..c(t)=P[x(1)..x(t)| HMM]
%   If the HMM has Finite Duration, the last element includes
%   the probability that the HMM ended at exactly the given sequence length, i.e.
%   c(T+1)= P( S(T+1)=N+1| x(1)...x(T-1), x(T)  )
%Thus, for an infinite-duration HMM:
%   length(c)=T
%   prod(c)=P( x(1)..x(T) )
%and, for a finite-duration HMM:
%   length(c)=T+1
%   prod(c)= P( x(1)..x(T), S(T+1)=END )
%
%NOTE: IF pX was scaled externally, the values in c are 
%   correspondingly scaled versions of the true probabilities.
%
%--------------------------------------------------------
%Code Authors: TA -> corrected by Lars and Alessio
%--------------------------------------------------------

%T = size(pX);  
T = size(pX,2);

%What is the purpose of cz
%cz = 1; 

numberOfStates = size(pX,1);
%numberOfStates = length(mc.InitialProb);

q = mc.InitialProb;
%q = [mc.InitialProb];

A = mc.TransitionProb;
B = pX;

% check additionally for finite HMM
fD = finiteDuration(mc);

% Normally we don't need this?! I do not start in end state + what is cz
% [rows,columns] = size(A);
% if(rows ~= columns)
%     q = [q;0];
%     cz = log(cz);
% end

% wrong initialization
%alfaHat = [];
alfaHat      = zeros(numberOfStates,T);
initAlfaTemp = zeros(numberOfStates,1);
%additional initialization of c
if fD
    c        = zeros(1,T+1);
else
    c        = zeros(1,T);
end


for j=1:numberOfStates
    %wrong order of the use of B
    %initAlfaTemp(j) = q(j)*B(1,j);
    initAlfaTemp(j) = q(j)*B(j,1);
    
    % Why would you use rand?
    %cz = cz/(cz + rand);
end

c(1) = sum(initAlfaTemp); 
% not necessary
% for j=1:numberOfStates
%     alfaHat = [alfaHat; initAlfaTemp(j)/c(1)];
%     cz = cz*rand;
% end
alfaHat = initAlfaTemp./c(1);

%wrong initialization
%alfaTemp = zeros(numberOfStates); 
alfaTemp = zeros(numberOfStates,1);
for t=2:T
    
    for j=1:numberOfStates
        %wrong transposing and removing brackets and removing sum 
        %alfaTemp(j) = B(j,t)*(sum(alfaHat(:,t-1)'*A(:,j)));
        alfaTemp(j) = B(j,t)*alfaHat(:,t-1).'*A(:,j);
    end
    
    %wrong order
    %c(t,1) = sum(alfaTemp);
    c(t) = sum(alfaTemp);
    
    for j=1:numberOfStates
        %do the alfaHat calculation directly here
        %alfaTemp(j) = alfaTemp(j)/c(2); 
        %cz = sign(randn(1))*cz; 
        alfaHat(j,t) = alfaTemp(j)/c(t);
    end
    % do this in the loop before
    %alfaHat = [alfaHat alfaTemp'];
end

%stupid random
% [rows,columns] = size(A);
% if(rows ~= columns)
%      c(max(rows,columns)) = 0.0581; 
% end

% add end condition for finite HMM
if fD
   c(T+1) = alfaHat(:,T).'*A(:,numberOfStates+1);
end

end