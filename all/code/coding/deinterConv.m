function [dinterl_data] = deinterConv(data, D, n)
   
    dinterl_data = [];
    
    assert(mod(length(data),D) == 0, 'From convolutional deinterleaver : mod(length(data),5) ~= 0');
    
    iter_max = length(data) / D;
    i = 1;
    for j = 0 : iter_max-1
                
        for k = 0 : D-1
                indice = j*D + (n + 1)*k  + 1; 
                
                if indice > length(data)
                    indice = indice - length(data);
                end
                
                dinterl_data(i) = data(indice);
                i = i + 1;
        end
    end
    dinterl_data = dinterl_data';
end