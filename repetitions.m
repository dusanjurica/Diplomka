%% Saving repetitions

clear all;
close all;
clc;

disp('########################################')
disp('#                                      #')
disp('#    Generating 1000 random signals    #')
disp('#                                      #')
disp('########################################')

reps = 2;
samples = 250;

figure()

for iter = 1:2:2*reps
    % Generovat signaly, ukladat je do promennych a udelat z nich kolekci
    % pro vhodnou analyzu
    [sig spec] = qpsk_signal( randsrc( 1,samples,[0,1] ) );
    subplot(reps, 2, iter)
    plot(sig)
    
    subplot(reps, 2, iter+1)
    plot(spec)
    
end

%% Evaluating propabilities of missdetection and false alarm

