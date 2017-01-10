clear all;

%% Variables
% For each of N channels assign no. of bits and genration of the data
% stream
% such that sum of all (bits/subchannel) = the data length.
N = 32; %No. of sub-channels
v = 5; % Cyclic prefix length
h1=[1 0.5 0.3 0.2 -0.1 0.02 0.05 0.08 0.01]; % channel impulse response.
h = h1(1);

%% Transmitter
%% Bit Allocation
allocation_table = zeros(1, N-1);
for i = 1:N-1
    % Since the SNR of each subchannel is unknown, bit loading is random
    % allocation_table(i) = ceil(rand*15); %Each tone is capable of
    % carrying
    % up to 15 bits regardless of the frequency at which it is transmitted.
    allocation_table(i) = ceil(rand*10);
end

%% Data generation and assignment in each channel
for i = 1:N-1
    data_channel = [];
    % data_channel is the particular data assigned to the subchannel.
    for j = 1:allocation_table(i),
        val = round(rand);
        data_channel = [data_channel val];
    end
    % data conatains all the data_channel values.
    data{i} = data_channel;
end

%% QAM
x_qam = [];
for i = 1:N-1
    %mat_bi = vec2mat(data{i}, allocation_table(i));
    mat_de = bi2de(data{i});
    x_qam = [x_qam qammod(mat_de, 2^allocation_table(i))];
end

%% DMT
% Calcuate the IFFT of the encoded complex symbol. Conjugate parts are
% added
x_dmt = ifft([1 x_qam 1 fliplr(conj(x_qam))]);

%% Cyclic prefix
% Define a cyclic prefix length and add the cyclic prefix to the serailized
% data stream.
x = [x_dmt(2*N+1 - v:2*N) x_dmt];

%% Channel
y_channel = conv(x, h);

%% Receiver
%% Removal of cyclic prefix
y = y_channel(v+1:2*N+v);

%% DMT demodulation
% Due to the cyclic prefix the convolution is translated to a circular
% convolution and hence the encoded complex symbol with its conjugate is 
% received after FFT demodulation 
y_dmt = fft(y)./fft(h,2*N);
% removing the conjugate parts
y_qam = y_dmt(2:N);

%% QAM demodulation
for i = 1:N-1
    symbol_rcv = qamdemod(y_qam(i), 2^allocation_table(i));
    data_rcv{i} = de2bi(symbol_rcv, allocation_table(i));
end

