%% QPSK Modulator
clear all
close all
clc


N=80; % Pocet datovych bitu
% Testovaci data, bud nahodne nebo same nuly
data = randsrc(1,N,[0 1]); % Generuje nahodna data podle slovniku [0,1]
%data = randsrc(1,N, [0,0]);
Rb = 10e3; % Bitrate
amplitude = 1;


% Rozlisi liche a sude datove bity
oddBits = data(1:2:end);
evenBits = data(2:2:end);

Fc = 20*Rb; % Kmitocet nosne vlny
% Zakodovana data pomoci skriptu NRZ encoder
[evenTime,evenNrzData,Fs]=NRZ_Encoder(evenBits,Rb,amplitude,'Polar');
[oddTime,oddNrzData]=NRZ_Encoder(oddBits,Rb,amplitude,'Polar');

% figure()
% subplot(211)
% plot(evenTime, evenNrzData)
% subplot(212)
% plot(oddTime, oddNrzData)

% Vytvori se synfazni a kvadraturni slozka
inPhaseOsc = 1/sqrt(2)*cos(2*pi*Fc*evenTime);
quadPhaseOsc = 1/sqrt(2)*sin(2*pi*Fc*oddTime);

% Vektor QPSK signalu
qpskModulated = oddNrzData.*quadPhaseOsc + evenNrzData.*inPhaseOsc;

% Vizualizace dat
figure()
subplot(211);
stem(data);
xlabel('Samples');
ylabel('Amplitude');
title('Input Binary Data');
axis([0,N,-0.5,1.5]);

subplot(212);
% [todo] nastudovat funkci plotHandle()
% Funkce plot vraci hodnotu, funkce plotHandle se pak dale asi vyuzije
plot(qpskModulated);
xlabel('Samples');
ylabel('Amplitude');
title('QPSK modulated Data');
xlimits = xlim;   
ylimits = ylim;
axis([xlimits,ylimits(1)-0.5,ylimits(2)+0.5]) ;
grid on;