% load handel;
load 'DemodFilter.mat';
[y,Fs] = audioread('composite_2radios.wav');
f1 = 6000;
f2 = 15000;
y1 = zeros(1014300,1);
y2 = zeros(1014300,1);
t = zeros(1014300,1);
f = zeros(1014300,1);

for n = 1:1014300
    t(n) = n*(1/Fs);
    y1(n) = y(n)*cos(2*pi*f1*t(n));
    y2(n) = y(n)*cos(2*pi*f2*t(n));
    f(n) = n*Fs/1014300;
end
Y1 = fft(y1);
Y2 = fft(y2);
H = fft(hImpResp,1014300);
X1 = Y1.*H;
X2 = Y2.*H;

figure;
plot(f,abs(X1));
xlabel('Hz');
ylabel('|X_1(f)|');

figure;
plot(f,abs(X2));
xlabel('Hz');
ylabel('|X_2(f)|');

x1_hat = ifft(Y1.*H);
x2_hat = ifft(Y2.*H);

figure;
plot(t,x1_hat);
xlabel('s');
ylabel('x_1(n)');

figure;
plot(t,x2_hat);
xlabel('s');
ylabel('x_2(n)');

audiowrite('AMradio1received_FD.wav',x1_hat,44100);
audiowrite('AMradio2received_FD.wav',x2_hat,44100);

H_mag = abs(fft(hImpResp,1014300));

figure;
plot(f,H_mag);
xlabel('Hz');
ylabel('|H(f)|');

% player = audioplayer(x1_hat, 44100);
% player2 = audioplayer(x2_hat, 44100);

