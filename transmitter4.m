% load handel;
% s1 = input('Input the 1st audio filename: ','s');
% s2 = input('Input the 2nd audio filename: ','s');
% s3 = input('Input the 3rd audio filename: ','s');
% s4 = input('Input the 4th audio filename: ','s');

s1 = 'AMradio1.wav';
s2 = 'AMchild.wav';
s3 = 'AMmusic.wav';
s4 = 'AMradio2.wav';

f1 = 3000;
f2 = 13000;
f3 = 18000;
f4 = 8000;
Fs = 44100;

[x1,Fs1] = audioread(s1);
[x2,Fs2] = audioread(s2);
[x3,Fs3] = audioread(s3);
[x4,Fs4] = audioread(s4);
t = zeros(1014300,1);
y = zeros(1014300,1);
f = zeros(1014300,1);

for n = 1:1014300
    t(n) = n*(1/Fs);
    y(n) = x1(n)*cos(2*pi*f1*t(n))+x2(n)*cos(2*pi*f2*t(n))+x3(n)*cos(2*pi*f3*t(n))+x4(n)*cos(2*pi*f4*t(n));
    f(n) = n*Fs/1014300;
end
Y = abs(fft(y));
y = y/max(abs(y));
audiowrite('composite_4radios.wav',y,44100);

figure;
plot(f,Y);
xlabel('Hz');
ylabel('|Y(f)|');

figure;
plot(t,x1);
xlabel('s');
ylabel('x_1(n)');

figure;
plot(t,x2);
xlabel('s');
ylabel('x_2(n)');

figure;
plot(t,x3);
xlabel('s');
ylabel('x_3(n)');

figure;
plot(t,x4);
xlabel('s');
ylabel('x_4(n)');

X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));
X4 = abs(fft(x4));

figure;
plot(f,X1);
xlabel('Hz');
ylabel('|X_1(f)|');

figure;
plot(f,X2);
xlabel('Hz');
ylabel('|X_2(f)|');

figure;
plot(f,X3);
xlabel('Hz');
ylabel('|X_3(f)|');

figure;
plot(f,X4);
xlabel('Hz');
ylabel('|X_4(f)|');

