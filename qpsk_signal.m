%% Funkce, jejimz vystupem bude QPSK signal v casove oblasti

function [qpsksig_noisy noise]=qpsk_signal(data, SNR)

    Rb = 1e2; % Bitrate
    amplitude = 0.8;


    % Rozlisi liche a sude datove bity
    oddBits = data(1:2:end);
    evenBits = data(2:2:end);

    Fc = 2*Rb; % Kmitocet nosne vlny

    % Zakodovana data pomoci skriptu NRZ encoder
    [evenTime,evenNrzData]=NRZ_Encoder(evenBits,Rb,amplitude,'manchester');
    [oddTime,oddNrzData]=NRZ_Encoder(oddBits,Rb,amplitude,'manchester');

    % Vytvori se synfazni a kvadraturni slozka
    inPhaseOsc = 1/sqrt(2)*cos(2*pi*Fc*evenTime);
    quadPhaseOsc = 1/sqrt(2)*sin(2*pi*Fc*oddTime);

    % Vektor QPSK signalu
    qpsksig_clean = oddNrzData.*quadPhaseOsc + evenNrzData.*inPhaseOsc;

    % Zasumime
    qpsksig_noisy = awgn(qpsksig_clean, SNR, 'measured');
    noise = qpsksig_noisy - qpsksig_clean;
    
end