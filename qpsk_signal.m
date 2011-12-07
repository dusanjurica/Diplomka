%% Funkce, jejimz vystupem bude QPSK signal v casove oblasti

function [qpsksig]=qpsk_signal(data, SNR)

Rb = 1e2; % Bitrate
amplitude = 0.8;


% Rozlisi liche a sude datove bity
oddBits = data(1:2:end);
evenBits = data(2:2:end);

Fc = 2*Rb; % Kmitocet nosne vlny

% Zakodovana data pomoci skriptu NRZ encoder
[evenTime,evenNrzData]=NRZ_Encoder(evenBits,Rb,amplitude,'Polar');
[oddTime,oddNrzData]=NRZ_Encoder(oddBits,Rb,amplitude,'Polar');

% Vytvori se synfazni a kvadraturni slozka
inPhaseOsc = 1/sqrt(2)*cos(2*pi*Fc*evenTime);
quadPhaseOsc = 1/sqrt(2)*sin(2*pi*Fc*oddTime);

% Vektor QPSK signalu
qpsksig = oddNrzData.*quadPhaseOsc + evenNrzData.*inPhaseOsc;

% Zasumime
qpsksig = awgn(qpsksig, SNR, 'measured');

% Nebude vracet spektrum
% 
% qpskspec = abs(fft(qpsksig));
% 
% % Vyfiltrujeme Raised Cosine filtrem
% 
% des = fdesign.pulseshaping(5, 'Raised Cosine', 'Nsym,Beta', 20, 0.5);
% filt = design(des);
% qpskspec = filter(filt,qpskspec);
% 
% % qpskspec = filter([0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ...
% %     0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ], 1, qpskspec);

end