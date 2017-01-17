clear all;

%% Variables
% For each of N channels assign no. of bits and genration of the data
% stream
% such that sum of all (bits/subchannel) = the data length.
N = 255; %No. of sub-channels
cyclic_prefix = 40; % Cyclic prefix length 40

H = rep_impulsionnelle_canal(2000, .8e-3);
Hr = [H(1:256) 0 conj(fliplr(H(1:256))) ];
h = ifft(Hr, 'symmetric');

h_est = channelEstimation(N, h);

%h = [1 0.5 0.3 0.2 -0.1 0.02 0.05 0.08 0.01]; % channel impulse response.

%% Transmitter
%% Bit Allocation
allocation_table = zeros(1, N);
for i = 1:N
    % Since the SNR of each subchannel is unknown, bit loading is random
    % allocation_table(i) = ceil(rand*15); %Each tone is capable of
    % carrying
    % up to 15 bits regardless of the frequency at which it is transmitted.
    allocation_table(i) = ceil(8);
end

%% Data generation and assignment in each channel
data = [];
for i = 1:N
    data_channel = [];
    % data_channel is the particular data assigned to the subchannel.
    for j = 1:allocation_table(i),
        val = round(rand);
        data_channel = [data_channel val];
    end
    % data conatains all the data_channel values.
    data = [data data_channel];
end

%% Transmitter
%% QAM
x_qam = modulationQAM(data, allocation_table);

%% DMT
x_dmt = modulationDMT(x_qam, N+1, cyclic_prefix);

%% Channel
y_channel = canal(x_dmt, 2000, .8e-3, 25);
%y_channel = conv(x_dmt, h);

%% Receiver
%% DMT demodulation
y_qam = demodulationDMT(y_channel, h, N+1, cyclic_prefix);

%% QAM demodulation
data_rcv = demodulationQAM(y_qam, allocation_table);

sum(abs(data - data_rcv))/length(data)