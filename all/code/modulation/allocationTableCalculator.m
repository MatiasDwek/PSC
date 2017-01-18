function allocation_table = allocationTableCalculator(h, maxQAM, N)
    H = fft(h);
    H = abs(H(1:255));
    
    minAllo = 1;
    
    maxH = max(H);
    minH = min(H);
    
    uni = linspace(maxH, minH, maxQAM - minAllo);
 
    allocation_table(1) = maxQAM;
    for jj = 2:N
        for kk = 2:maxQAM - minAllo - 1
            if ((H(jj) <= uni(kk)) && (H(jj) >= uni(kk + 1)))
                allocation_table(jj) = maxQAM - kk;
            end
        end
    end
end