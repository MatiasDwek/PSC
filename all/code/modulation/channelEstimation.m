function h_est = channelEstimation(N, h)

cyclic_prefix = 40; % Cyclic prefix length 40
mean_weight = 30;

%% Transmitter
%% Bit Allocation
allocation_table = zeros(1, N);
for i = 1:N
    % Since the SNR of each subchannel is unknown, bit loading is random
    % allocation_table(i) = ceil(rand*15); %Each tone is capable of
    % carrying
    % up to 15 bits regardless of the frequency at which it is transmitted.
    allocation_table(i) = ceil(4);
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
y_all = [];
for i = 1:mean_weight
    %% QAM
    x_qam = modulationQAM(data, allocation_table);

    %% DMT
    x_dmt = modulationDMT(x_qam, N, cyclic_prefix);

    %% Channel
    y_channel = canal_ext(x_dmt, 2000, .8e-3, 25);
    y_all = [y_all; y_channel];
end

%% Receiver
y_mean = sum(y_all) / mean_weight;

%y_mean = conv(x_dmt, h);

Y_mean = fft(y_mean);
H_est = Y_mean./fft([x_dmt zeros(1,length(y_mean) - length(x_dmt))]);
h_est = ifft(H_est);
h_est = h_est(1:length(h));
h_est = real(h_est);

end