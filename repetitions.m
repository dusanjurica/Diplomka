%% Saving repetitions

clear all;
close all;
clc;

disp('########################################')
disp('#                                      #')
disp('#    Generating 1000 random signals    #')
disp('#                                      #')
disp('########################################')

reps = 10;
samples = 80;

figure()

% for iter = 1:2:2*reps
%     % Generovat signaly, ukladat je do promennych a udelat z nich kolekci
%     % pro vhodnou analyzu
%     [sig spec] = qpsk_signal( randsrc( 1,samples,[0 1] ) );
%     subplot(reps, 2, iter)
%     plot(sig)
%     
%     subplot(reps, 2, iter+1)
%     plot(spec)  
% end

% for iter = 1:reps
%     % Generovat nahodne useky QPSK signalu
%     sig = qpsk_signal( randsrc( 1,samples,[0 1] ), 1.2 );
%     subplot(reps, 1, iter);
%     plot(sig)
% end

data_vector =  randsrc(1,samples,[0 1]);
iter = 1;

% Nahodne vybrane hodnoty SNR a zobrazeny signal QPSK od -30dB do 25dB

for snr = -30:5:25
    sig = qpsk_signal(data_vector, snr);
    subplot(6,2,iter);
    plot(sig)
    title(['Actual SNR : ',int2str(snr)]);
    
    iter = iter + 1;
end

%% Evaluating propabilities of missdetection and false alarm

