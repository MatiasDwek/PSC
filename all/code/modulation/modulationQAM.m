function x_qam = modulationQAM(x, allocation_table)
N = length(allocation_table) + 1;
x_qam = [];

for i = 1:N-1
    if i == 1
        mat_de = bi2de(x(1:allocation_table(i)));
    else
        mat_de = bi2de(x(sum(allocation_table(1:i-1))+1:sum(allocation_table(1:i))));
    end
    x_qam = [x_qam qammod(mat_de, 2^allocation_table(i))];
end