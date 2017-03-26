clc; clear all; close all;
addpath('GetSpeechFeatures')
%Load data
[y_female,fs_female]    = audioread('female.wav');
[y_male,fs_male]        = audioread('male.wav');
[y_music,fs_music]      = audioread('music.wav');

%time domain vectors, scaled with the corresponding time period.
t_female                = 1/fs_female*(0:length(y_female)-1)';
t_male                  = 1/fs_male*(0:length(y_male)-1)';
t_music                 = 1/fs_music*(0:length(y_music)-1)';
%%
%plot of the music signal and female speech in time
figure(1)
subplot(2,1,1); plot(t_female,y_female);
ylabel('Signal amplitude'); xlabel('Time in seconds');grid;
title('Female voice signal');
subplot(2,1,2); plot(t_music,y_music);
ylabel('Signal amplitude'); xlabel('Time in seconds'); grid;
title('Music signal');

%plot of the music signal zoomed from 0.62 to 0.76 seconds
figure;
indexes_music = t_music > 0.62 & t_music < 0.76; 
plot(t_music(indexes_music),y_music(indexes_music));
ylabel('Signal amplitude'); xlabel('Time in seconds'); grid;
title('Music signal - Armonics pattern');
%plot of the female speech zoomed with voiced/unvoiced patterns

indexes_female_unvoiced = t_female > 0.17 & t_female < 0.26; %unvoiced pattern,corresponds to s ( i shot...)
indexes_female_voiced = t_female > 0 & t_female < 0.1; %voiced pattern, corresponds to i ( i ...)
figure;
subplot(211);
plot(t_female(indexes_female_unvoiced),y_female(indexes_female_unvoiced));
ylabel('Signal amplitude'); xlabel('Time in seconds');grid;
title('Female voice signal - Unvoiced pattern');
subplot(212);
plot(t_female(indexes_female_voiced),y_female(indexes_female_voiced));
ylabel('Signal amplitude'); xlabel('Time in seconds');grid;
title('Female voice signal - voiced pattern');
%% 2 - Analyze frequency signal
window_length = 0.03; %in ms
num_cepstral  = 13;

[mfccs_f,spectgram_f,f_f,t_f]       = GetSpeechFeatures(y_female,...
                                fs_female,window_length,num_cepstral);
[mfccs_mu,spectgram_mu,f_mu,t_mu]   = GetSpeechFeatures(y_music,...
                                fs_music,window_length,num_cepstral);
[mfccs_ma,spectgram_ma,f_ma,t_ma]   = GetSpeechFeatures(y_male,...
                                fs_male,window_length,num_cepstral);


figure(2)
imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz');
annotation('arrow',[0.2 0.25],[0.85 0.9]); annotation('arrow',[0.15 0.2],[0.65 0.7]);
figure(3)
imagesc(t_mu,f_mu,log10(spectgram_mu)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz');
annotation('arrow',[0.2 0.25],[0.83 0.88]);

%% 3 - Analyze using cepstrum
% mean the signal
mfccs_f = mfccs_f-repmat(mean(mfccs_f,2),1,size(mfccs_f,2));
mfccs_mu = mfccs_mu-repmat(mean(mfccs_mu,2),1,size(mfccs_mu,2));
mfccs_ma = mfccs_ma-repmat(mean(mfccs_ma,2),1,size(mfccs_ma,2));
% normalize variance to 1
norm_f   = (std(mfccs_f.')).';
mfccs_fn = mfccs_f.*repmat((1./norm_f),1,size(mfccs_f,2));
norm_m   = (std(mfccs_mu.')).';
mfccs_mn = mfccs_mu.*repmat((1./norm_m),1,size(mfccs_mu,2));
norm_ma   = (std(mfccs_ma.')).';
mfccs_man = mfccs_ma.*repmat((1./norm_ma),1,size(mfccs_ma,2));

figure(4)
subplot(2,1,1); imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Female voice')
subplot(2,1,2); imagesc(t_f,1:num_cepstral,mfccs_fn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');

figure(5)
subplot(2,1,1); imagesc(t_mu,f_mu,log10(spectgram_mu)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Music')
subplot(2,1,2); imagesc(t_mu,1:num_cepstral,mfccs_mn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');

figure(6)
subplot(2,1,1); imagesc(t_ma,f_ma,log10(spectgram_ma)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Male voice')
subplot(2,1,2); imagesc(t_ma,1:num_cepstral,mfccs_man); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');

figure(7)
subplot(2,1,1); imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Female voice - Spectrogram')
subplot(2,1,2); imagesc(t_mu,f_mu,log10(spectgram_mu)); colormap jet;
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Music - Spectrogram')

figure(8)
subplot(2,1,1); imagesc(t_f,1:num_cepstral,mfccs_fn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS'); title('Female voice - Cepstrogram')
subplot(2,1,2); imagesc(t_mu,1:num_cepstral,mfccs_mn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS'); title('Music - Cepstrogram')

figure(9)
subplot(2,1,1); imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Female voice - Spectrogram')
subplot(2,1,2); imagesc(t_ma,f_ma,log10(spectgram_ma)); colormap jet;
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Male voice - Spectrogram')

figure(10)
subplot(2,1,1); imagesc(t_f,1:num_cepstral,mfccs_fn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS'); title('Female voice - Cepstrogram')
subplot(2,1,2); imagesc(t_ma,1:num_cepstral,mfccs_man); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS'); title('Male voice - Cepstrogram')

%% 4 - Calc correlation matrices
frame = 100;

[c_spectra,rho1] = corr(log10(spectgram_f(:,1:frame)).');
[c_cepstra,rho2] = corr(mfccs_f(:,1:frame).');
figure(11)
subplot(1,2,1); imagesc(abs(c_spectra)); title('Correlation - Female voice');...
    xlabel('Frequency bins'); ylabel('Frequency bins');
    colormap gray;
subplot(1,2,2); imagesc(abs(c_cepstra)); title('Correlation - Female voice');...
    xlabel('Cepstral Coefficient'); ylabel('Cepstral Coefficient');
    colormap gray;

%% 5 - use derivatives
window_length = 0.03; %in ms
num_cepstral  = 13;

[mfcc,f,t] = mfcc_dyn(y_female, fs_female, window_length, num_cepstral);
% delta = diff(mfccs_f.')*fs_female;
% deltadelta = diff(delta)*fs_female;