addpath('../sounds/lars');
addpath('../sounds/natalie');
addpath('../sounds/martin');
addpath('../sounds/alessio');
%addpath('/Users/lars/Dropbox/Project/sounds/paolo');
addpath('GetSpeechFeatures');


sNames  = {'lars','martin','natalie','alessio'};
nPeople = length(sNames);
sWords  = {'recognition','environment','affect','effect','I','am','in','is','lars','alessio','hand','chair','markov','stockholm'};
nWords  = length(sWords);

% MFCC parameters
fs              = 22050;
nCepstral       = 13;
nFeatures       = 3*nCepstral;
windowLength    = 0.03;


% read sounddata first and perform feature extraction
for j=1:nWords
    for i=1:nPeople
        fExist = 1;
        counter= 1;
        while fExist
            % convert counter to string manually
            if counter<10
                number = ['0' num2str(counter)];
            else
                number = num2str(counter);
            end
            
            % Read single file!
            identifier = [char(sNames(i)) '_' char(sWords(j)) '-' number '.wav'];
            if exist(identifier);
                % time data
                data{j,i,counter}       = audioread(identifier);
                % MFCC
                features{j,i,counter}   = mfcc_dyn(data{j,i,counter},fs,windowLength,nCepstral);
                counter = counter + 1;
            else
                fExist = 0;
            end
        end
    end
end
