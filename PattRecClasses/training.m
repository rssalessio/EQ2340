% Training procedure for speech recognition
clc; clear all; close all;

fTraining = 0;

%% Read data and load parameters
readData
%% k means sorting - k fold with options from 1 to 5
[training1,validation1,lTraining1,lValidation1] = kfold(1,features,nWords,nPeople);
[training2,validation2,lTraining2,lValidation2] = kfold(2,features,nWords,nPeople);
[training3,validation3,lTraining3,lValidation3] = kfold(3,features,nWords,nPeople);
[training4,validation4,lTraining4,lValidation4] = kfold(4,features,nWords,nPeople);
[training5,validation5,lTraining5,lValidation5] = kfold(5,features,nWords,nPeople);


%% training
if fTraining
    nStates=[6,6,4,4,3,... %recognition,environment,affect,effect,I
        4,4,4,4,4,...      %am,in,is,Lars,Alessio
        4,4,4,4];          %hand,chair,markov,Stockholm

    for j=1:nWords  
        gmm(j)  = MakeGMM(nStates(j),training5{j});
        hmm(j)  = MakeLeftRightHMM(nStates(j),gmm(j),training5{j},lTraining5(j,:));
    end
end









