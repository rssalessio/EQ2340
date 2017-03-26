%% create comparison
j = 6;
feature = 2;
close all;

for k = 1:48

    real = real+training4{j}(feature,lTraining4(j,k)*(k-1)+1:124+lTraining4(j,k)*(k-1));

end

real2 = training4{j}(feature,1:lTraining4(j,1));
real = real./48;

    sim  =  rand(hmm(j),lTraining4(j,1));
% figure()
% subplot(2,1,1)
% plot(real)
% subplot(2,1,2)
% plot(sim(feature,:))
% 
% figure
% subplot(2,1,1)
% hist(real,50)
% subplot(212)
% hist(sim(feature,:),50)
figure()
subplot(2,1,1)
plot(real2);
title('Recorded data');
xlabel('Time samples'); ylabel('MFCC')
grid; 
subplot(2,1,2)
plot(sim(feature,:))
grid;
title('Random data');
xlabel('Time samples'); ylabel('MFCC')
figure
subplot(2,1,1)
hist(real2,50);
xlim([-1.5 3])
subplot(212)
hist(sim(feature,:),50)

xlim([-1.5 3])