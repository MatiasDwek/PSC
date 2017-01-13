%%%%%%%%%% Modelisation du Canal %%%%%%%%%%%

% IN : longueur du canal, diam�tre des fils de cuivre (entre 0.4 et 0.8mm)
%|| OUT : reponse impulsionnelle (Tableau de 256 valeurs)
%wire: UTP (no shielded)

function [H]= rep_impulsionnelle_canal(longueur, d)

%%%%%%%%%% Constantes %%%%%%%%%%%

muV=4*pi*10^-7;                 % Permeabilite du vide
muCu = 1.5;                     % Permeabilite du cuivre
epsilonV=(1/(36*pi))*10^-9;     % Permitivite de l'air
epsilonR=1.5;                   % Permitivite de l'isolant
rho=17*10^-9;                   % Resistivite du cuivre
D= d/2;                         % Distance entre les fils
%255 intervalles de  4,3125 kHz (0 to 1.1 MHz) 
freq=(0:4.3125e3:1.104e6);      % Vecteur de frequence


%%%%%%%%%% Grandeurs Primaires %%%%%%%%%%%

%Resistance
R(1:256) = (sqrt((muV*muCu*rho)/(pi))*sqrt(freq(1:256))/d); 
%Capacite
C= (pi*epsilonV*epsilonR)/(log(D/d)+sqrt((D/d)^2-1));         
%Inductance
L= ((muV*muCu/pi)*log((D/d)+sqrt((D/d)^2-1)));                  
%Conductivite
G = 2*10^-6; 

%Constante de propagation
Gamma(1:256)=0;
for i=1:256
    Gamma(i)=sqrt((R(i)+(1i*L*2*pi*freq(i)))*(G+(1i*C*2*pi*freq(i))));  
end;

%%%%%%%%%% Reponse impulsionnelle %%%%%%%%%%%
H(1:256)=0;
for i=1:256
    H(i)=0.5*exp(-Gamma(i)*longueur);
end;

%%%%%%%%%% Graphes %%%%%%%%%%%

Hr = [H(1:256) 0 conj(fliplr(H(2:256))) ];

figure(2)
subplot(211);

plot(20*log(abs(Hr)));
title('h en freq')

subplot(212);
plot(ifft(Hr, 'symmetric'))
title('h en temporel')
grid on


end