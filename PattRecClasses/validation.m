% Validation procedure for speech recognition
%clc; clear all; close all;
%%
fAll = 1;

a=[];
correct_ratio=[];
correct_decisions=[];
for j=1:nWords
    for kk=1:size(lValidation4,2)
        if kk==1
            [~,a1(j,kk)] = max(logprob(hmm,validation4{j}(:,1:lValidation4(j,1))));
        else
            [~,a1(j,kk)] = max(logprob(hmm,validation4{j}(:,lValidation4(j,kk-1)+1:lValidation4(j,kk-1)+1+lValidation4(j,kk))));
        end
    end 
end

if fAll==1
    for j=1:nWords
        for kk=1:size(lTraining4,2)
            if kk==1
                [~,a2(j,kk)] = max(logprob(hmm,training4{j}(:,1:lTraining4(j,1))));
            else
                [~,a2(j,kk)] = max(logprob(hmm,training4{j}(:,lTraining4(j,kk-1)+1:lTraining4(j,kk-1)+1+lTraining4(j,kk))));
            end
        end
    end
    
    a = [a a1 a2];
else
    a = [a a1];
end


%% Calculate and plot ratio of correct decisions
for j=1:nWords
    correct_decisions = find(a(j,:)==j);
    correct_ratio(j)  = numel(correct_decisions)/length(a(j,:));
end
correct_ratio
figure(1)
plot(correct_ratio,'x')
xlabel('Word number'); ylabel('Ratio of correct decisions')
xlim([0.5 14.5]); ylim([-0.05 1.05]);

%% Calculate misclassification matrix
C = zeros(nWords,nWords);
for j=1:nWords
   for i=1:size(a,2)
      if a(j,i)==j
          C(j,j) = C(j,j) + 1;
      else
          C(j,a(j,i)) = C(j,a(j,i)) + 1;
      end
   end
end