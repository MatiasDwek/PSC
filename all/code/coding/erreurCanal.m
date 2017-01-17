function [output, nbreErrBin] = erreurCanal(input, tauxErr)
    output = [];
    for i = 1 : length(input);
        j = randi([1 1000]);
        if j < tauxErr * 10
            output = [output ; ~input(i)];
        else
            output = [output ; input(i)];
        end
    end
    
    
    nbreErrBin = 0;
    for i = 1 : length(input)
        if output(i) ~= input(i)
            nbreErrBin = nbreErrBin + 1;
        end
    end
end