function y_qam = demodulationDMT(y_channel, h, N, cyclic_prefix)
%% Removal of cyclic prefix
y = y_channel(cyclic_prefix+1:2*N+cyclic_prefix);

%% DMT demodulation
% Due to the cyclic prefix the convolution is translated to a circular
% convolution and hence the encoded complex symbol with its conjugate is 
% received after FFT demodulation
y_dmt = fft(y)./fft(h,2*N);

% removing the conjugate parts
y_qam = y_dmt(2:N);