clc; clear all; close all;
addpath('GetSpeechFeatures')
%Load data
[y_snap1,fs_snap1]      = audioread('fly.aiff');
[y_snap2,fs_snap2]      = audioread('vuvuzela.wav');
%y_snap1 = (y_snap1(:,1)+y_snap1(:,2))./2;
y_snap2 = (y_snap2(:,1)+y_snap2(:,2))./2;

%time domain vectors, scaled with the corresponding time period.
t_snap1                 = 1/fs_snap1*(0:length(y_snap1)-1)';
t_snap2                 = 1/fs_snap2*(0:length(y_snap2)-1)';
%%
figure(1)
subplot(2,1,1); plot(t_snap1,y_snap1);
ylabel('Signal amplitude'); xlabel('Time in seconds');grid;
title('Fly signal'); axis tight;
subplot(2,1,2); plot(t_snap2,y_snap2);
ylabel('Signal amplitude'); xlabel('Time in seconds'); grid;
title('Vuvuzela signal'); axis tight;
%%
window_length = 0.03; %in ms
num_cepstral  = 13;

[mfccs_f,spectgram_f,f_f,t_f]       = GetSpeechFeatures(y_snap1,...
                                fs_snap1,window_length,num_cepstral);
[mfccs_mu,spectgram_mu,f_mu,t_mu]   = GetSpeechFeatures(y_snap2,...
                                fs_snap2,window_length,num_cepstral);


figure(2)
imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz');colorbar;
figure(3)
imagesc(t_mu,f_mu,log10(spectgram_mu)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz');colorbar;

%%
mfccs_f = mfccs_f-repmat(mean(mfccs_f,2),1,size(mfccs_f,2));
mfccs_mu = mfccs_mu-repmat(mean(mfccs_mu,2),1,size(mfccs_mu,2));
% normalize variance to 1
norm_f   = (std(mfccs_f.')).';
mfccs_fn = mfccs_f.*repmat((1./norm_f),1,size(mfccs_f,2));
norm_m   = (std(mfccs_mu.')).';
mfccs_mn = mfccs_mu.*repmat((1./norm_m),1,size(mfccs_mu,2));

figure(4)
subplot(2,1,1); imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Fly')
subplot(2,1,2); imagesc(t_f,1:num_cepstral,mfccs_fn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');

figure(5)
subplot(2,1,1); imagesc(t_mu,f_mu,log10(spectgram_mu)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Vuvuzela')
subplot(2,1,2); imagesc(t_mu,1:num_cepstral,mfccs_mn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');

