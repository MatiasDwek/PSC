figure()

%legend('H','H estimé');
plot(abs(H(1:155)))


title('Réponse du canal')

xlabel('Canaux') % x-axis label
ylabel('Amplitude') % y-axis label


set(gca,'fontsize',16)
