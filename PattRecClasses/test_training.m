%% Just for testing, perform manual training and tweaking for one parameter
j = 1;
nStates(j) =4;
gmm(j)  = MakeGMM(nStates(j),training4{j});
hmm(j)  = MakeLeftRightHMM(nStates(j),gmm(j),training4{j},lTraining4(j,:));
%%
for kk=1:12
    if kk==1
        [~,a(j,kk)] = max(logprob(hmm,validation4{j}(:,1:lValidation4(j,1))));
    else
        [~,a(j,kk)] = max(logprob(hmm,validation4{j}(:,lValidation4(j,kk-1)+1:lValidation4(j,kk-1)+1+lValidation4(j,kk))));
    end
end

correct_decisions = find(a(j,:)==j);
correct_ratio(j)  = numel(correct_decisions)/length(a(j,:))