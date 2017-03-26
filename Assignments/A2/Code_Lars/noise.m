clc; clear all; close all;
addpath('GetSpeechFeatures')
%Load data
[y_snap1,fs_snap1]      = audioread('noise.wav');
y_snap1 = (y_snap1(:,1)+y_snap1(:,2))./2;

%time domain vectors, scaled with the corresponding time period.
t_snap1                 = 1/fs_snap1*(0:length(y_snap1)-1)';
t_snap1 = t_snap1(t_snap1 < 3);
y_snap1 = y_snap1(t_snap1 < 3);
%%
figure(1)
 plot(t_snap1,y_snap1);
ylabel('Signal amplitude'); xlabel('Time in seconds');grid;
title('Fly signal'); axis tight;
%%
window_length = 0.03; %in ms
num_cepstral  = 13;

[mfccs_f,spectgram_f,f_f,t_f]       = GetSpeechFeatures(y_snap1,...
                                fs_snap1,window_length,num_cepstral);


figure(2)
imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz');colorbar;

%%
mfccs_f = mfccs_f-repmat(mean(mfccs_f,2),1,size(mfccs_f,2));
% normalize variance to 1
norm_f   = (std(mfccs_f.')).';
mfccs_fn = mfccs_f.*repmat((1./norm_f),1,size(mfccs_f,2));

figure(4)
subplot(2,1,1); imagesc(t_f,f_f,log10(spectgram_f)); colormap jet
xlabel('Time in seconds'); ylabel('Frequency in Hz'); title('Fly')
subplot(2,1,2); imagesc(t_f,1:num_cepstral,mfccs_fn); colormap jet
xlabel('Time in seconds'); ylabel('MFCCS');


% For ARMA, do not need to specify nb and nk
  idFuncOpt = armaxOptions;
  idFuncOpt.Focus = 'simulation';
th = armax(iddata(y_snap1,[] ,1/44100),[1 3])
sys = tf(th.a,th.c,1/44100);
y = y_snap1 - lsim(sys,y_snap1,t_snap1);