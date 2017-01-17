function crcBin=calcul_CRC(bit_suit,M)
    %cette fonction permet de calculer crc de certain bits au choix(M)
    
    assert(length(bit_suit) == (239-4) * 8, 'length not equal to 239-4 * 8');
    crcBin = [];
    bit_suit = bit_suit';
    
    for i = 0 : 7
   
        g=[1 0 0 1 1];%g(x)=x4+x+1 et il genere 4bits redandance
        R=length(g)-1; %longeur de bit redandence
        ll=length(bit_suit);
        if (mod(ll,M)==0)
            nb_sy=ll/M;
        else
            nb_sy=ll/M+1;
        end
        code_crc=[];
        for i=1:nb_sy
                ll_new=length(bit_suit);
                if (ll_new<M)
                    data_ori=bit_suit;
                    data=[bit_suit zeros(1,M-ll_new)];
                else
                    data_ori=bit_suit(1:M);
                    data=bit_suit(1:M);
                end
                [q,r]=deconv([data zeros(1,R)],g);
                %ce que on veut c'est le reste, il faut l'ajoute a la fin du code
                r=(r(end-R+1:end));
                r=mod(r,2);%modulos de 2
                code_part=[data_ori r];
                bit_suit=bit_suit(M+1:end);
                code_crc=[code_crc code_part];

        end

        code_crc = code_crc';
    
        crcBin = [crcBin ; code_crc];
    end
end