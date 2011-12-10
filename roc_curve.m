%% Main function
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
samples = 200;

% Generuj nahodny datovy vektor
data_vector =  randsrc(1,samples,[0 1]);

% Pocet vzorku v prumerovacim podvektoru
M = 10;

% Testovaci hodnota pomeru SNR, viditelne zmeny jsou v intervalu -1 az 6 dB
snr = 4;

% Moduluj vygenerovana data na nosnou, vznikne qpsk signal
[sig noise] = qpsk_signal(data_vector, snr);

% Prealokace vektoru, kvuli rychlosti
sig_squares = zeros(1, length(sig)/M);
noise_squares = zeros(1, length(noise)/M);

% Pomocny iterator
iter = 1;

% Rozdeli vektor sig na dilci kusy (plovouci okno, jede po jednom vzorku az
% do konce vektoru
for i = 0:length(sig)
    if (i==0)
        sig_squares(iter) = sum( sig(1:10).^2 );
    elseif (i < length(sig)-M)
        sig_squares(iter) = sum( sig(i:(i+M)).^2 );
    else
    end
    iter = iter + 1;
end

iter = 1;

% Rozdeli vektor noise na dilci kusy (plovouci okno, jede po jednom vzorku
% az do konce vektoru
for i = 0:length(noise)
    if (i==0)
        noise_squares(iter) = sum( noise(1:10).^2 );
    elseif (i < length(noise)-M)
        noise_squares(iter) = sum( noise(i:(i+M)).^2 );
    else
    end
    iter = iter + 1;
end

figure()
subplot(311)
plot(sig_squares)
ylim([0 20])
subplot(312)
plot(noise_squares)
ylim([0 20])

subplot(313)
P_fa = 0;
P_d = 0;

for threshold = 0 : 0.2 : 5
    
    % Analyzuje pouze sum, vypocita P_fa (pravdepodobnost falesneho
    % poplachu)
    mp = 0;
    for i = 1:length(noise_squares)
        if (noise_squares(i) > threshold)
            mp = mp + 1;
        end
    end
    % Pravdepodobnost falesneho poplachu
    if (P_fa == 0)
        P_fa = mp / length(noise_squares);
    else
        % P_fa se kazdou iteraci zvetsuje, coz je spravne, matlab tomu
        % nerozumi
        P_fa = [P_fa, (mp / length(noise_squares))];
    end
    
    mp = 0;
    for i = 1:length(sig_squares)
        if (sig_squares(i) > threshold)
            mp = mp + 1;
        end
    end
    % Pravdepodobnost spravne detekce
    if (P_d == 0)
        P_d = mp / length(sig_squares);
    else
        % P_d se taky kazdou iteraci zvetsuje, to je taky spravne
        P_d = [P_d, (mp / length(sig_squares))];
    end
end

plot(P_fa, P_d, 'g-');
title('Receiver operating curve');
xlabel('P_{fa} - propability of false alarm');
ylabel('P_d - propability of detection');
ylim([-0.3 1.5])
xlim([-0.3 1.5])

%% Vykresleni signalu a sumu, nic duleziteho
% Nakreslime
figure()
subplot(211)
plot(sig, 'g')
title(['Actual SNR : ',int2str(snr)]);
ylim([-2 2]);

subplot(212)
plot(noise, 'r')
title('Noise, subtracted from firstly generated qpsk signal');
ylim([-2 2])