%% Saving repetitions

clear all;
close all;
clc;

disp('########################################')
disp('#                                      #')
disp('#      Receiver operating curve        #')
disp('#                                      #')
disp('########################################')

% Pocet vzorku pro simulaci, delka signalu pak bude 5x delsi, nutno
% zjistit proc?
samples = 100;

% Generuj nahodny datovy vektor
data_vector =  randsrc(1,samples,[0 1]);

% Pocet vzorku v prumerovacim podvektoru
M = 10;

% Testovaci hodnota pomeru SNR bude natvrdo nastavena
snr = 8;

% Moduluj vygenerovana data na nosnou, vznikne qpsk signal
[sig noise] = qpsk_signal(data_vector, snr);

% Prealokace vektoru avg, kvuli rychlosti
avg_vector = zeros(1, length(sig)/M);
% disp(avg_vector)

% iter :: pomocny iterator
iter = 1;

% Rozdeli vektor signalu na urcity pocet kousku podle maximalniho poctu
% vzorku M specifikovaneho vyse, pro kazdy usek vzorku M spocita sumu
% ctvercu a ulozi do vektoru avg
for i = 0:M:length(sig)
    disp(i)
    if (i==0)
        avg_vector(iter) = sum( sig(1:10) )^2;
    elseif (i < length(sig))
        avg_vector(iter) = sum( sig(i:(i+10)) )^2;
    else
    end
    iter = iter + 1;
end

% Nafoukne vektor avg na stejnou delku jako vektor signalu
for i = 1:length(avg_vector)
    % 
end

% Sectu ctverce jednotlivych vzorku
ssum = 0;
for i = 1:length(sig)
    ssum = ssum + sig(i)^2;
end

% Podelenim poctem vzorku ziskame vykon signalu
%ssum = ssum / length(sig); 

% Nakreslime
figure()
subplot(311)
plot(sig, 'g')
title(['Actual SNR : ',int2str(snr), ', Decision metric : ', num2str(ssum)]);
ylim([-2 2]);

subplot(312)
plot(noise, 'r')
title('Noise, subtracted from firstly generated qpsk signal');
ylim([-2 2])

threshold = 4.4.*ones(1,50);

figure()
plot(avg_vector, 'b')
title('Average value')
ylim([-2 15])
hold on
plot(threshold, 'm')