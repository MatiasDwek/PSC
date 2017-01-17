clear all; close all;

%% Scrambler

scr = comm.Scrambler(10,[0 -2 -5], zeros(5, 1));
dscr = comm.Descrambler(10,[0 -2 -5], zeros(5,1));

data = [1  : 5]';
scrData = step(scr,data);
dscrData = step(dscr, scrData);

fprintf('Scrambler polynomiale (p = 1 + x^-2 + x -5) : \n')
data = data'
scrData = scrData'
dscrData = dscrData'


%% Reed Solomon

N = 7;
K = 4;

gp = rsgenpoly(N,K,[],0);
enc = comm.RSEncoder(N,K, gp); 
dec = comm.RSDecoder(N,K, gp);

data = [1 : 4]';
encData = step(enc, data);
decData = step(dec, encDataRS);

fprintf('\n\nCode RS (N = %d, K = %d) : \n', N, K)
data = data'
encDataRS = encDataRS'
decDataRS = decDataRS'
%% interleaver
fprintf('\n\nInterleaver D = 5, N = 2 : \n')
data = [1 : 15]
itlvr_data = interConv(data, 5, 2, 0)'
