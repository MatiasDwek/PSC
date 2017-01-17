function [interleaver_data] = interConv(data, D, n, debug)
   
    interleaver_data = [];
    
    assert(mod(length(data),D) == 0, 'From convolutional interleaver : mod(length(data),5) ~= 0');
    
    for i = 1 : length(data)
        j = mod(i + mod(i-1,D)*n, length(data)); % indice dans la trame en sortie 
       
        if j == 0
           j = length(data); % cas du dernier indice
        end
        
        interleaver_data(j) = data(i);
      
        if debug == 1
           interleaver_data 
        end
    end
        interleaver_data = interleaver_data';
    
    interleaver_data(1) = data(1);
 
end