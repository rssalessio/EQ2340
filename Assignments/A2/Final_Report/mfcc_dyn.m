function [MFCC,f,t] = mfcc_dyn(signal,fs,window_length,num_cepstral)

% Calculate Cepstral
[mfccs,~,f,t]       = GetSpeechFeatures(signal,...
                                fs,window_length,num_cepstral);
% Make the signal have 0 mean and unit variance
mfccs       = mfccs-repmat(mean(mfccs,2),1,size(mfccs,2));
norm_f      = (std(mfccs.')).';
MFCC        = mfccs.*repmat((1./norm_f),1,size(mfccs,2));
% Calculate dynamic features
delta       = diff(MFCC.');
delta_f     = [delta(1,:) ;delta];
deltadelta  = diff(delta);
deltadelta_f= [deltadelta(1,:); deltadelta(1,:); deltadelta];
% Concatenate dynamic features into whole feature vector
MFCC        = [MFCC;delta_f.';deltadelta_f.'];

end