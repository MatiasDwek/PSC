function x_dmt = modulationDMT(x_qam, N, cyclic_prefix)

% Calcuate the IFFT of the encoded complex symbol. Conjugate parts are
% added
x_dmt = ifft([1 x_qam 1 fliplr(conj(x_qam))]);

% Define a cyclic prefix length and add the cyclic prefix to the serailized
% data stream.
x_dmt = [x_dmt(2*N+1 - cyclic_prefix:2*N) x_dmt];