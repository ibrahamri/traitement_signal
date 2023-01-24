clear all;
close all 
clc


f1=500;
f2=400;
f3=50;
Te=0.0001;
Fe=1/Te;
t=0:Te:5-Te;
N=length(t);

x=sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);
%  representation temporelle du signal
 subplot(3,1,1)
 plot(t,x)
 grid on
 title(" représentation graphique x(T)")
 xlabel("t")
 ylabel("x(t)")
%%%
%  representation frequentielle du signal
f=(0:N-1)*(Fe/N);
y = fft(x);
fshift=(-N/2:N/2-1)*(Fe/N);

subplot(3,1,2)
plot(fshift,fftshift(abs(y)));
grid on
title(" la transformée de fourier du signal ECG")
xlabel("f")
ylabel("Tfd")
%%%


% filter
k = 1;
w=2*pi*f;
wc = 50;
wc1 = 500;
wc2 = 1000;
%la transmitance complexe 
H1= (k*1j*((w)/wc))./(1+1j*((w)/wc));
H2 = (k*1j*((w)/wc1))./(1+1j*((w)/wc1));
H3 = (k*1j*((w)/wc2))./(1+1j*((w)/wc2));



%diagramme de bode en fct du gain&& diagramme de bode en fct de la phase 



% diagramme de bode en fct du gain
G = 20*log(abs(H));
G1 = 20*log(abs(H1));
G2 = 20*log(abs(H2));
%diagramme de bode en fct de la phase 
P = angle(h);
P1 = angle(H1);
P2 = angle(H2);


%represantation de daigramme de bonde en fc de module

subplot(3,1,2)
semilogx(f,G,f,G1,f,G2);
title("Diagramme de Bode")
xlabel("rad/s")
ylabel("decibel")
legend("G : wc=50","G1 : wc=500","G2 : wc=1000")

%represantation de daigramme de bonde en fc de phase

subplot(3,1,3)
semilogx(f,P,f,P1,f,P2)
legend("P","P1","P2")


% FILTER DANS LE DOMAINE FRQ
signal_filtr = H1.*y;
signal_filtr2 = H2.*y;
signal_filtr3= H3.*y;

fl1=fftshift(abs(signal_filtr));
fl2=fftshift(abs(signal_filtr2));
fl3=fftshift(abs(signal_filtr3));

%represontation  de signal filtre dans le domaine frq fftshift 
subplot(1,3,1)
plot(fshift,fl1)
xlim([0,1000])
subplot(1,3,2)
plot(fshift,fl2)
xlim([0,1000])
subplot(1,3,3)
plot(fshift,fl3)
xlim([0,1000])


% FILTER SIGNAL DANS LE DOMAINE T

x1=ifft(signal_filtr,"symmetric");
x2=ifft(signal_filtr2,"symmetric");
x3=ifft(signal_filtr3,"symmetric");
subplot(4,1,1);
plot(t,x);
xlim([0,0.25])
subplot(4,1,2);
plot(t,x1);
xlim([0,0.25])
subplot(4,1,3);
plot(t,x2);
xlim([0,0.25])
subplot(4,1,4);
plot(t,x3);
xlim([0,0.25])






