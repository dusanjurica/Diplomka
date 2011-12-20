%% Testovaci(finalni) skript pro tvorbu receiver operating curves

% Je potreba vygenerovat jeden signal, ten v cyklu zasumet podle aktualni
% hodnoty SNR, potom menit detekcni prahy a vynaset do grafu. Vysledkem by
% melo byt ROC ruzne zohybana pro ruzne hodnoty SNR

% Generuj signal bez sumu

% Cyklus, ve kterem se signal zasumi, nastavi se prahy, vynesou se body
% a utvori tak ROC. Pro kazdou hodnotu SNR vzdy jedna ROC krivka

% Rozmitat hodnotu SNR

for snr=-10:1.5:10
    
end

% Rozmitat delku akumulacniho vektoru M
for M = 5:1:15
    
end