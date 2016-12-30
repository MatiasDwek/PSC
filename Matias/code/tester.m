clear all;
%clc;

%% Variables
% For each of N channels assign no. of bits and genration of the data stream
% such that sum of all (bits/subchannel) = the data length.
N=32; %No. of sub-channels
v=5; % Cyclic prefix length
h1=[1 0.5 0.3 0.2 -0.1 0.02 0.05 0.08 0.01]; % channel impulse response.
h = h1(1);

%% Bit Allocation
allocation_table = zeros(1, N-1);
for i = 1:N-1
    %Since the SNR of each subchannel is unknown, bit loading is random
    allocation_table(i) = 2^round(log2(ceil(rand*14 + 1))); %Each tone is capable of carrying up to 15 bits regardless of the frequency at which it is transmitted.
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
for i = 1:N-1
    mat_bi = vec2mat(data{i}, log2(allocation_table(i)));
    mat_de = bi2de(mat_bi);
    data_qam{i} = qammod(mat_de, allocation_table(i));
end

%% DMT
for i = 1:N-1
    data_dmt{i} = ifft([1 complex_symbol 1 fliplr(conj(complex_symbol))], 2*N);
end