x = [5 6 8 2 5]; 
h = [6 -1 3 5 1];
x1 = [x zeros(1,4)];
h1 = [h zeros(1,4)];
y1 = ifft(fft(x1).*fft(h1));
y2 = conv(x,h);

Y2 = fft(y2);
H_est = Y2./fft(x1);
h_est = ifft(H_est);
h_est = h_est(1:length(h))