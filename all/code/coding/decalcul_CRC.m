function [nbreErr,crcBin]=decalcul_CRC(bit_suit,M)

    %cette fonction permet de decoder crc de certain bits au choix(M)
    %%%M est le bit d'info
    
    assert(length(bit_suit) == (239) * 8, 'length not equal to 239 * 8');
    crcBin = [];
    nbreErr = [];
    
    for i = 0 : 7
        
        bit_suit = bit_suit';
        g=[1 0 0 1 1];%g(x)=x4+x+1 et il genere 4bits redandance
        R=length(g)-1; %longeur de bit redandence
        ll=length(bit_suit);
        nb_erreur=0;
        if mod(ll,M+R)==0
            nb_sy=ll/(M+R);
        else
            nb_sy=ll/(M+R)+1;
        end
        decode_crc=[];
        for i=1:nb_sy
                ll_new=length(bit_suit);
                if (ll_new<M+R)
                    data=[bit_suit(1:ll_new-R) zeros(1,M-(ll_new-R)) bit_suit(ll_new-R+1:end)];
                    data_ori=bit_suit;
                else
                    data=bit_suit(1:M+R);
                end
                [q,r]=deconv(data,g);
                % %detecter l'erreur
                r=(r(end-R+1:end));
                r=mod(r,2);%modulos de 2
                if sum(sum(r))==0
                    nb_erreur=nb_erreur+0;
                else
                    nb_erreur=nb_erreur+1;
                end
                %enleve les bits redandance
                if (ll_new>=M+R)
                    code_part=data(1:M);
                else
                    code_part=data_ori(1:end-R);%M-(ll_new-R) est le longeur de bit zeros
                end
                decode_crc=[decode_crc code_part];
                 %mis a jour le bit_suit
                bit_suit=bit_suit(M+R+1:end);

        end

        decode_crc = decode_crc';
        nbreErr = nbreErr + nb_erreur;
        crcBin = [crcBin  decode_crc];
    end
end