function[word_array] = bin2int(input, word_length) 

    word_array = [];
    
    while length(input) > 1
        bit = input(1 : word_length,1);
        input(1 : word_length) = [];
        int = bi2de(fliplr(bit'));
        word_array = [word_array; int];
    end
end