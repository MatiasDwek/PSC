function [sig]= sinus()

% Génération d'un sinus et ajout d'un bruit blanc Gaussien

        fe = 8000;      % Fréquence d'échantillonnage
        N = 512;       % Nombre de points de la séquence

        % Axe des temps
        t = (1:N)/fe;
        
        % Génération du sinus
        f0 = 1200;
        sig = sin(2*pi*f0*t);
        
        %BANDPOWER
%         sum=0;
%         [~,m]=size(sig);
%         for i=1:m
%             sum=sum+sig(i)^2;
%         end
%         sum/m
%         bandpower(sig)
%         (sum/m)-bandpower(sig)
        
end