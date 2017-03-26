function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors: Alessio Russo(911103-T192), Lars Lindemann (891113-4131) 
%---------------------------------------------

    nS      = mc.nStates; %number of states, nS+1 is the END state for finite chains
    S       = zeros(1,T);%space for resulting row vector
    isFinite= finiteDuration(mc); %1 if mc is of finite duration

    i       = 1; %current step
    S(1,i)  = rand(DiscreteD(mc.InitialProb),1); %draw the inital state from the given initial probability mass function

    
    %the while loop as to cycle until the final state nS+1 is reached for
    %finite sequences or until step i=T
    for i=2:T
        hGen        = DiscreteD(mc.TransitionProb(S(1,i-1),:));
        S(1,i)      = rand(hGen,1);
        % in case of a final mc: check if final state is reached
        if S(1,i)==nS+1 && isFinite
            %reset of end state
            S(1,i)  = 0;
            usedS   = find(S~=0);
            S       = S(1,usedS);
            break;
        end
    end


end


