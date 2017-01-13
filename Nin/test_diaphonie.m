function [  ] = test_diaphonie()

%diaphonie(signal,longueur,diametre,nbSignalPerturbant)
%longueur 1000, diametre 0.8
%test signal sinus

    longueur=1000;
    diametre=0.8;
    signal=sinus();
    [~,tailleSignal]=size(signal);
    
    diaph1=diaphonie(signal,longueur,diametre,3);
    diaph2=diaphonie(signal,longueur,diametre,25);
    diaph3=diaphonie(signal,longueur,diametre,50);
    
    scale_time = linspace(0,13e-3, tailleSignal);
    figure('Name','sinus avec diaphonie fonction nbSignalPerturbant','NumberTitle','off')
    
%     subplot(411)
%     plot(signal)
%     title('signal sans diaphonie')
    
    subplot(211)
    plot(scale_time,diaph1)
    title('3 signaux perturbants')
    
    subplot(212)
    plot(scale_time,diaph2)
    title('25 signaux perturbants')
    
    
%     subplot(414)
%     plot(scale_time,diaph3)
%     title('50 signaux perturbants')
    
end
    


