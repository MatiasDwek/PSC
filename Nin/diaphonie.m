function [signal_diaph] = diaphonie(signal,longueur,diametre,nbSignalPerturbant)
%tant que nbSignalPerturbant <50
%signal doit faire 512 points

    [~,tailleSignal]=size(signal);
    
    
    freq=(0:4.3125e3:1.104e6);      % Vecteur de frequence
    %valeur abs de la reponse impulsionnelle du canal
    h=abs(rep_impulsionnelle_canal(longueur,diametre));
    

    %bruit pour exciter DSP
    bruit = awgn(zeros(1,256),0);
    bruit=fft(bruit);               %passage en frequence
        
    %constantes
    fH=1.104e6;
    fH2=25875;
    fL=4000;
    f0=2.208e6;
    
    %calcul DSP
    for i=1:256
        lpf2(i)=(fH^11.96)/(((freq(i)).^(11.96))+fH^11.96);
        hpf2(i)=(freq(i).^7.09+fL^7.09)/(freq(i).^7.09+fH2^7.09);

        DSPperturb(i)=0.1104*2/f0*pow2(sinc(pi*freq(i)/f0))*lpf2(i)*hpf2(i);
        hFEXT2(i)=h(i).^2*(8e-20)*freq(i).^2*3.28*(nbSignalPerturbant/49)^0.6;

        DSPFext(i)=DSPperturb(i)*hFEXT2(i);
        DSPNext(i)=DSPperturb(i)*0.8536e-14*nbSignalPerturbant^0.6*freq(i).^(3/2);

        DSPFext(i) = abs(bruit(i)).^2*DSPFext(i);
        DSPNext(i) = abs(bruit(i)).^2*DSPNext(i);
    end
    
    %passage en temporel
    Fext = ifft(DSPFext, tailleSignal);
    Next = ifft(DSPNext, tailleSignal);
    
    signal_diaph=signal+Fext+Next;              %signal prenant en compte la diaphonie
    
    
%     %%%%%Graphe%%%%%
%     %passage en dB
%     NextdB = 10*log10(DSPNext/1e-3);
%     FextdB = 10*log10(DSPFext/1e-3);
%     %echelles
%     scale = linspace(0,1.1e6,256);
%     scale_time = linspace(0,13e-3, tailleSignal);
%     
%     figure
%     subplot(2,2,1)
%     plot(scale,FextdB)
%     title('DSP Fext')
%     subplot(2,2,2)
%     plot(scale,NextdB)
%     title('DSP Next')
%     subplot(2,2,3)
%     plot(scale_time,Fext)
%     title('Fext en temps')
%     subplot(2,2,4)
%     plot(scale_time,Next)
%     title('Next en temps')
% 
%     figure(22)
%     plot(scale_time,signal_diaph)
%     title('signal avec diaphonie')

end