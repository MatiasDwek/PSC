function [bin_array] = int2bin(input, word_length)

    bin_array = [];
    while length(input) > 0 
        word = input(1);
        bin = fliplr(de2bi(word));
        bin = [zeros(1, word_length-length(bin)) bin]; %complete la trame de zero pour avoir une taille de word_length
        bin_array = [bin_array bin];
        input(1) = [];
    end
    bin_array = bin_array';
end