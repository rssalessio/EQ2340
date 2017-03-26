a = randn(5000,1);
[b,bb] = hist(a,50);
values = -1:1/25:1-1/25;
j=1;

for i=1:length(b)
    c(j:j+b(i)-1) = values(i)*ones(b(i),1);
    if b(i)==0
        j = j;
    else
        j = j+b(i);
    end
end
figure(1)
subplot(3,1,1)
plot(hist(a,50))
subplot(3,1,2)
plot(a)
subplot(3,1,3)
plot(xcorr(a))


figure(2)
subplot(3,1,1)
plot(hist(c,50))
subplot(3,1,2)
plot(c)
subplot(3,1,3)
plot(xcorr(c))