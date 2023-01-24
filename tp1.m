clear all
close all
clc

%  representation temporelle du signal
fe = 1e4;
te = 1/fe;
N  = 5000;
t = (0:N-1)*te;
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);
plot(t,x)
grid on
title(" représentation de signl dans le domaine temporelle");
xlabel("t");
ylabel("x(t)");

%  representation frequentielle du signal

y = fft(x);
f = (0:N-1)*(fe/N);
plot(f,abs(y))
grid on
title(" représentation de signl dans le domaine frequentielle");
xlabel("f");
ylabel("x(f)");

%representation frequentielle du signal (fftshift)

fshift = (-N/2:N/2-1)*(fe/N);
plot(fshift,fftshift(abs(y)));
title(" représentation de signl dans le domaine frequentielle centree");
xlabel("shift");
ylabel("fftshift(abs(y))");


% % % % % % % % % % % % % % % % % % 


%creation de bruit
noise = randn(size(x));
plot(t,noise);
title(" représentation de bruit dans le temps");
xlabel("t");
ylabel("noise(t)");

% ajouter le bruit dans signal

xnoise = x + noise;
ynoise = fft(xnoise);
%tracage de signal bruitee en fonction de temps

plot(t,xnoise)

%representation frequentielle du signal bruite (fftshift)
plot(fshift,fftshift(abs(ynoise)))
title(" représentation de signal avec le bruit en foction du f");
xlabel("fshift");
ylabel("fftshift(abs(ynoise)");


% Conception de filtre

pass_bas = zeros(size(x));
fc = 3000;
index_fc = ceil((fc*N)/fe);
pass_bas(1:index_fc) = 1;
pass_bas(N-index_fc+1:N) = 1;

% filtrge

sigfilfrek = pass_bas.*ynoise;

subplot(3,1,1)
% représentation de signal avec le bruit en foction du f
plot(fshift,fftshift(abs(ynoise)))
title(" représentation de signal avec le bruit en foction du f");
xlabel("fshift");
ylabel("fftshift(abs(ynoise)");
subplot(3,1,2)

% représentation de signal avec le filtrie en foction du f (fftshift)
plot(fshift,fftshift(abs(fft(sigfiltmp))))
title(" représentation de signal filtree en foction du f");
xlabel("fshift");
ylabel("fftshift(abs(signalfltr)");

subplot(3,1,3)

% représentation de signal avec le filtrie en foction du temps (fftshift)
sigfiltmp = ifft(sigfilfrek,'symmetric');
plot(t,sigfiltmp)
title(" représentation de signal filtree en foction du t");
xlabel("t");
ylabel("signalfltr");

%Analyse fréquentielle du chant du rorqual bleu

[x,fe]=audioread("bluewhale.au");
chant = x(2.45e4:3.10e4);
% sound(chant,fe)
N = length(chant);
te = 1/fe;
t = (0:N-1)*(10*te);
subplot(2,1,1)
plot(t,chant)

y = abs(fft(chant)).^2/N; 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));

