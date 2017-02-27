% load handel;
f1 = 6000;
f2 = 15000;
y = zeros(1014300,1);
t = zeros(1014300,1);
f = zeros(1014300,1);

% s1 = input('Input the first audio filename: ','s');
% s2 = input('Input the second audio filename: ','s');
% [x1,Fs1] = audioread(s1);
% [x2,Fs2] = audioread(s2);

[x1,Fs1] = audioread('AMradio1.wav');
[x2,Fs2] = audioread('AMradio2.wav');

X1 = abs(fft(x1));
X2 = abs(fft(x2));

for n = 1:1014300
    t(n) = n*(1/Fs1);
    y(n) = x1(n)*cos(2*pi*f1*t(n))+x2(n)*cos(2*pi*f2*t(n));
    f(n) = n*Fs1/1014300;
end

Y = abs(fft(y));

figure;
plot(t,x1);
xlabel('s');
ylabel('x_1(n)');

figure;
plot(t,x2);
xlabel('s');
ylabel('x_2(n)');

figure;
plot(t,y);
xlabel('s');
ylabel('y(n)');

figure;
plot(f,X1);
xlabel('Hz');
ylabel('|X_1(f)|');

figure;
plot(f,X2);
xlabel('Hz');
ylabel('|X_2(f)|');

figure;
plot(f,Y);
xlabel('Hz');
ylabel('|Y(f)|');

% y = y/max(abs(y));
audiowrite('composite_2radios.wav',y,44100);

% player = audioplayer(y,Fs1);
% player2 = audioplayer(y,Fs1);



