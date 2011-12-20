function [ofdm_signal noise]=ofdm_signal(snr)

    Nsymb=64*1000;
    symb=randsrc(1,Nsymb,[-3 -1 1 3])+1j*randsrc(1,Nsymb,[-3 -1 1 3]);

    M1=reshape(symb,64,Nsymb/64);
    M2=[M1(1:32,:); zeros(64,Nsymb/64); M1(33:64,:)];    
    M3=ifft(M2);
    clean_signal=reshape(M3,1,size(M3,1)*size(M3,2));
    
    norm=max(clean_signal);
    clean_signal=(1/norm).*clean_signal;
    ofdm_signal=awgn(clean_signal, snr, 'measured');
    noise = ofdm_signal - clean_signal;
    
    % Useful things
    
%     figure();
%     subplot(211)
%     % plot(real(signal))
%     % plot(imag(signal))
%     plot(signal)
%     
%     subplot(212)
%     psd(signal);
%     
%     figure();
%     hist(abs(signal),20);        % histogram absolutnich hodnot
%     
%     figure();
%     hist(real(signal),40);       % histogram realne casti signalu
% 
%     M4=reshape(signal,size(M3,1), size(M3,2));
%     M5=fft(M4);
%     M6=[M5(1:32,:); M5(end-31:end,:)];
%     size(M6);
%     
%     figure();
%     plot(M6,'.');
%     
%     figure();
%     plot(M1-M6,'.');
%     
%     figure();
%     data=reshape(M1,1,Nsymb);
%     plot(data,'.');
    
end