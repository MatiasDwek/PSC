function [  ] = test_rep_impulsionnelle()
    
    %%%%%%%en fonction de la longueur de ligne %%%%%%%%
    H1=rep_impulsionnelle_canal(100,0.8);
    H2=rep_impulsionnelle_canal(1000,0.8);
    H3=rep_impulsionnelle_canal(10000,0.8);
        

    figure('Name','h fonction longueur ligne','NumberTitle','off')
    
    subplot(321);
    plot(abs(H1),'r')
    title('h')
    xlabel('porteuse');
    ylabel('amplitude');
    
    subplot(322)
    plot(20*log(abs(H1)),'r');
    title('h échelle log')
    legend('100m')

    
    subplot(323);
    plot(abs(H2),'g')
    subplot(324)
    plot(20*log(abs(H2)),'g');
    legend('1km')

    subplot(325);
    plot(abs(H3),'b')
    subplot(326)
    plot(20*log(abs(H3)),'b');
    legend('10km')    
    
    
    %%%%%fonction diametre%%%%%%
    H1=rep_impulsionnelle_canal(1000,0.4);
    H2=rep_impulsionnelle_canal(1000,0.8);
    
    figure('Name','h fonction diametre ligne','NumberTitle','off')
    
    subplot(321);
    plot(abs(H1),'r')
    title('h')
    xlabel('porteuse');
    ylabel('amplitude');
    
    subplot(322)
    plot(20*log(abs(H1)),'r');
    title('h échelle log')
    legend('0.4mm')

    
    subplot(323);
    plot(abs(H2),'g')
    subplot(324)
    plot(20*log(abs(H2)),'g');
    legend('0.8mm')

    subplot(325);
    plot(abs(abs(H1)-abs(H2)))
    title('difference')

end

