a=tic;
disp('Start speaking in 3 seconds!')
pause(1);
disp('Start speaking in 2 seconds!')
pause(1);
disp('Start speaking in 1 seconds!')
pause(1);
disp('Start speaking now!')
recObj = audiorecorder(22050,16,1);
recordblocking(recObj,2)
disp('Recording ended!')
play(recObj)
data = getaudiodata(recObj);

features   = mfcc_dyn(data,22050,0.03,13);
[~,a] = max(logprob(hmm,features));
disp(a)