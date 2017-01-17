function [signal_recu]=canal(signal_module,longueur,diametre,nbSignalPerturbant)

% La fonction canal permet de simuler un canal r�el, int�grant du bruit et de la diaphonie.
% Tous les �chantillons sortant du modulateur DMT traverseront
% ce canal pour finalement �tre envoy�es au d�modulateur.
% x_mod est le vecteur sorti du modulateur DMT.
% longeur est la longueur canal.
%diametre le diametre des fils (entre 0.4 et 0.8mm)
%nbSignalPerturbant le nombre de signaux qui agissent dans la diaphonie

H=rep_impulsionnelle_canal(longueur,diametre);

Hr = [H(1:256) 0 conj(fliplr(H(1:256))) ];
h = ifft(Hr, 'symmetric');

signal_filtre=conv(signal_module,h);
[~,m]=size(signal_module);

% %%%%%%%%Bruit thermique AWGN%%%%%%%
k = 1.3806*10^-23;  %Constante de Boltzmann
T = 13.6+273.15;    %Temperature en Kelvin, 13.6 temperature moyenne en france (2015)
B = 1.1*10^6;       %Bande passante 
No = k*T*B;         %Puissance de bruit en W

Psignal_module=bandpower(signal_filtre);    %Puissance du signal en W

n = 256; %Number of information bits per symbol OFDM
snr=(10*log(Psignal_module))/(10*log(No)) +10*log(n);

signal_bruite=awgn(signal_filtre,snr);

% %%%%%%%diaphonie%%%%%%%%
signal_recu=diaphonie(signal_bruite,longueur,diametre,nbSignalPerturbant);