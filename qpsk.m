%% QPSK Modulator
clear all
close all
clc


N=500; % Pocet datovych bitu
% Testovaci data, bud nahodne nebo same nuly
data = randsrc(1,N,[0 1]); % Generuje nahodna data podle slovniku [0,1]
%data = randsrc(1,N, [0,0]);
Rb = 1e3; % Bitrate
amplitude = 1;


% Rozlisi liche a sude datove bity
oddBits = data(1:2:end);
evenBits = data(2:2:end);

figure()
subplot(311)
title('Pure data bits')
stem(data)
% Limity rozsahu os musi byt za volanim funkce stem(), jinak to nefunguje
ylim([-0.3 1.2])

Fc = 2*Rb; % Kmitocet nosne vlny

% Zakodovana data pomoci skriptu NRZ encoder
[evenTime,evenNrzData,Fs]=NRZ_Encoder(evenBits,Rb,amplitude,'Polar');
[oddTime,oddNrzData]=NRZ_Encoder(oddBits,Rb,amplitude,'Polar');

% Vytvori se synfazni a kvadraturni slozka
inPhaseOsc = 1/sqrt(2)*cos(2*pi*Fc*evenTime);
quadPhaseOsc = 1/sqrt(2)*sin(2*pi*Fc*oddTime);

% Vektor QPSK signalu
qpskModulated = oddNrzData.*quadPhaseOsc + evenNrzData.*inPhaseOsc;

% Vizualizace dat
Tb=1/Rb;
subplot(312);
stem(data);
xlabel('Samples');
ylabel('Amplitude');
title('Input Binary Data');
axis([0,N,-0.5,1.5]);

subplot(313);
% [todo] nastudovat funkci plotHandle()
% Funkce plot vraci hodnotu, funkce plotHandle se pak dale asi vyuzije
plotHandle=plot(qpskModulated);
xlabel('Samples');
ylabel('Amplitude');
title('QPSK modulated Data');
xlimits = xlim;   
ylimits = ylim;
axis([xlimits,ylimits(1)-0.5,ylimits(2)+0.5]) ;
grid on;

% Ted uz mame QPSK signal, ktery nese informaci.
% Udelame rychlou fourierovu transformaci

fftqpskmodulated = abs(fft(qpskModulated));
% fftqpskmodulated = filter([0.2 0.2 0.2 0.2 0.2], 1, fftqpskmodulated);
figure()
subplot(211)
plot(fftqpskmodulated);
title('fft of qpsk modulated data');
xlabel('frequency [Hz]');
ylabel('value [V]');
grid on;

subplot(212)
% Vyfiltrovat signal filtrem s koeficienty 1/N delky N
fftqpskmodulated = filter([0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ...
    0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 ], 1, fftqpskmodulated);
plot(fftqpskmodulated);

title('fft of qpsk modulated data');
xlabel('frequency [Hz]');
ylabel('value [V]');
grid on;

% Ulozit nekolik analyz do souboru, tyto pak postoupit naladeni detekcniho
% prahu





















