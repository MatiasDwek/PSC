function data_rcv = demodulationQAM(y_qam, allocation_table)

N = length(allocation_table) + 1;
data_rcv = [];
for i = 1:N-1
    symbol_rcv = qamdemod(y_qam(i), 2^allocation_table(i));
    data_rcv = [data_rcv de2bi(symbol_rcv, allocation_table(i))];
end