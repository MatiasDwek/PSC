function [signal_recu]=canal(signal_module,longueur,diametre,nbSignalPerturbant)

% La fonction canal permet de simuler un canal r�el, int�grant du bruit et de la diaphonie.
% Tous les �chantillons sortant du modulateur DMT traverseront
% ce canal pour finalement �tre envoy�es au d�modulateur.
% x_mod est le vecteur sorti du modulateur DMT.
% longeur est la longueur canal.
%diametre le diametre des fils (entre 0.4 et 0.8mm)
%nbSignalPerturbant le nombre de signaux qui agissent dans la diaphonie

h=rep_impulsionnelle_canal(longueur,diametre);
signal_module=conv(signal_module,h);

%%%%%%%%Bruit thermique AWGN%%%%%%%
k = 1.3806*10^-23;  %Constante de Boltzmann
T = 13.6+273.15;    %Temperature en Kelvin, 13.6 temperature moyenne en france (2015)
B = 1.1*10^6;       %Bande passante 
No = k*T*B;         %Puissance de bruit en W

Psignal_module=bandpower(signal_module);    %Puissance du signal en W

snr=(10*log(Psignal_module))/(10*log(No));

signal_bruite=awgn(signal_module,snr);

%%%%%%%diaphonie%%%%%%%%
signal_recu=diaphonie(signal_bruite,longueur,diametre,nbSignalPerturbant); 


%%%%%%%Graphe%%%%%%%
[~,tailleSignal]=size(signal_module);
scale_time = linspace(0,200,tailleSignal);
figure
    subplot(2,2,1)
    plot(scale_time,signal_module)
    title('Signal de départ')
    subplot(2,2,2)
    plot(scale_time,signal_bruite)
    title('Signal bruite')
    subplot(2,2,3)
    plot(scale_time,signal_recu)
    title('Signal recu : bruit et diaphonie')

end