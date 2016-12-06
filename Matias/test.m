fs = .1;
signal_frequency = 1;
t = 0:fs:10;
f = t * signal_frequency;

signal = cos(2*pi*signal_frequency*t);

signal_f = (fft(signal));
plot(f, abs(signal_f));