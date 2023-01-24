clear all
close all
clc


% % % % % % % % % % % % % % % % % % % % % % % % % % 
% converter un audio a un siganl

[music, fs] = audioread('test.wav');
% save('testt.mat', 'y', 'fs');
music = music';
N=length(music);
te = 1/fs;% fs=fe
t = (0:N-1)*te;

f = (0:N-1)*(fs/N);
fshift = (-N/2:N/2-1)*(fs/N);

y_trans = fft(music);
%  representation temporelle du signal

subplot(3,1,1)
plot(t,music)
subplot(3,1,2)

%  representation frequentielle du signal

plot(fshift,fftshift(abs(y_trans)))


% % % % % % % % % % % % % % % % % % % % % % % % % % % 
%filtrage analogique

k = 1;
fc = 5000;

%la transmitance complexe

h =k./(1+1j*(f/fc).^1000);
h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

% diagramme de bode en fct du gain
G = 20*log(abs(h));
semilogx(f,G);
title("Diagramme de Bode")
xlabel("rad/s")
ylabel("decibel")
%diagramme de bode en fct de la phase 
P = angle(h);
semilogx(f,P)
title("Diagramme de Bode")
xlabel("f")
ylabel("rad")

%tracage de filter dans le domaine t
semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)


%application de filter
y_filtr = y_trans(1:end-1).*h_filter;
sig_filtred= ifft(y_filtr,"symmetric");

% represntation du signal filtre dans le domaine frq
plot(fshift(1:end-1),fftshift(abs(fft(sig_filtred))))

