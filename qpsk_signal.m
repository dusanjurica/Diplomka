%% Funkce, jejimz vystupem bude QPSK signal v casove oblasti

function [qpsksig, qpskspec]=qpsk_signal(data)

Rb = 1e3; % Bitrate
amplitude = 1;


% Rozlisi liche a sude datove bity
oddBits = data(1:2:end);
evenBits = data(2:2:end);

Fc = 20000; % Kmitocet nosne vlny

% Zakodovana data pomoci skriptu NRZ encoder
[evenTime,evenNrzData,Fs]=NRZ_Encoder(evenBits,Rb,amplitude,'Polar');
[oddTime,oddNrzData]=NRZ_Encoder(oddBits,Rb,amplitude,'Polar');

% Vytvori se synfazni a kvadraturni slozka
inPhaseOsc = 1/sqrt(2)*cos(2*pi*Fc*evenTime);
quadPhaseOsc = 1/sqrt(2)*sin(2*pi*Fc*oddTime);

% Vektor QPSK signalu
qpsksig = oddNrzData.*quadPhaseOsc + evenNrzData.*inPhaseOsc;

qpskspec = abs(fft(qpsksig));

qpskspec = filter([0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ...
    0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ], 1, qpskspec);

end