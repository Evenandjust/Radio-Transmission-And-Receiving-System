% @author: XZZ
% @function: Receiving part of the system, in time domain.

% load handel;
load 'DemodFilter.mat';
[y,Fs] = audioread('composite_2radios.wav');

f1 = 6000;
f2 = 15000;
y1 = zeros(1014300,1);
y2 = zeros(1014300,1);
t1 = zeros(1014300,1);
t2 = zeros(1014375,1);
f = zeros(1014375,1);

for m = 1:1014300
    t1(m) = m*(1/Fs);
    y1(m) = y(m)*cos(2*pi*f1*t1(m));
    y2(m) = y(m)*cos(2*pi*f2*t1(m));
    
end

for n = 1:1014375
    t2(n) = n*(1/Fs);
    f(n) = n*Fs/1014375;
end

x_hat_1 = conv(y1,hImpResp);
x_hat_2 = conv(y2,hImpResp);

audiowrite('AMradio1received_TD.wav',x_hat_1,44100);
audiowrite('AMradio2received_TD.wav',x_hat_2,44100);

% figure;
% plot(htime,hImpResp);
% title('h(n)');

figure;
plot(t2,x_hat_1);
xlabel('s');
ylabel('x_1(n)');

figure;
plot(t2,x_hat_2);
xlabel('s');
ylabel('x_2(n)');

% player = audioplayer(x_hat_1,44100);
% player2 = audioplayer(x_hat_2,44100);
