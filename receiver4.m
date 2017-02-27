load handel;
load 'DemodFilter.mat';
[y,Fs] = audioread('composite_4radios.wav');
f1 = 3000;
f2 = 13000;
f3 = 18000;
f4 = 8000;
y1 = zeros(1014300,1);
y2 = zeros(1014300,1);
y3 = zeros(1014300,1);
y4 = zeros(1014300,1);
t = zeros(1014300,1);
f = zeros(1014300,1);

for n = 1:1014300
    t(n) = n*(1/Fs);
    y1(n) = y(n)*cos(2*pi*f1*t(n));
    y2(n) = y(n)*cos(2*pi*f2*t(n));
    y3(n) = y(n)*cos(2*pi*f3*t(n));
    y4(n) = y(n)*cos(2*pi*f4*t(n));
    f(n) = n*Fs/1014300;
end

Y1 = fft(y1);
Y2 = fft(y2);
Y3 = fft(y3);
Y4 = fft(y4);
H = fft(hImpResp,1014300);
X1 = Y1.*H;
X2 = Y2.*H;
X3 = Y3.*H;
X4 = Y4.*H;

x1_hat = ifft(Y1.*H);
x2_hat = ifft(Y2.*H);
x3_hat = ifft(Y3.*H);
x4_hat = ifft(Y4.*H);

figure;
plot(t,x1_hat);
xlabel('s');
ylabel('x_1(n)');

figure;
plot(t,x2_hat);
xlabel('s');
ylabel('x_2(n)');

figure;
plot(t,x3_hat);
xlabel('s');
ylabel('x_3(n)');

figure;
plot(t,x4_hat);
xlabel('s');
ylabel('x_4(n)');

figure;
plot(f,abs(X1));
xlabel('Hz');
ylabel('|X_1(f)|');

figure;
plot(f,abs(X2));
xlabel('Hz');
ylabel('|X_2(f)|');

figure;
plot(f,abs(X3));
xlabel('Hz');
ylabel('|X_3(f)|');

figure;
plot(f,abs(X4));
xlabel('Hz');
ylabel('|X_4(f)|');

audiowrite('AMradio1received_4.wav',x1_hat,44100);
audiowrite('AMchildreceived_4.wav',x2_hat,44100);
audiowrite('AMmusicreceived_4.wav',x3_hat,44100);
audiowrite('AMradio2received_4.wav',x4_hat,44100);

player1 = audioplayer(x1_hat,44100);
player2 = audioplayer(x2_hat,44100);
player3 = audioplayer(x3_hat,44100);
player4 = audioplayer(x4_hat,44100);

