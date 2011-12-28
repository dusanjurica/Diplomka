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
    ofdm_signal = abs(ofdm_signal).^2;
    noise = ofdm_signal - clean_signal;
    
end