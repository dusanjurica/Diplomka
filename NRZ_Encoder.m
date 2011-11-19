% NRZ_Encoder   Line codes encoder
%   [time,output,Fs]=NRZ_Encoder(input,Rb,amplitude,style)
%   NRZ_Encoder NRZ encoder
%   Author: Mathuranathan
%   Input a stream of bits and specify bit-Rate, amplitude of the output signal and the style of encoding
%   Currently 3 encoding styles are supported namely 'Manchester','Unipolar'and 'Polar'
%   Outputs the NRZ stream
function [time,output,Fs]=NRZ_Encoder(input,Rb,amplitude,style)

%For debug
%clear all;
%input=[1 0 1 0 0 1 1];
%Tb = 0.01; % bit period (s)
%Fs = 400; % Sampling Freq  Fs >=1/T (Hz)
Fs=10*Rb; %Sampling frequency , oversampling factor= 32
Ts=1/Fs; % Sampling Period
Tb=1/Rb; % Bit period

output=[];
switch lower(style)
    case {'manchester'}
        %disp('Method is ,manchester')
        for count=1:length(input),
            for tempTime=0:Ts:Tb/2-Ts,
                output=[output (-1)^(input(count))*amplitude];
            end        
            for tempTime=Tb/2:Ts:Tb-Ts,
                output=[output (-1)^(input(count)+1)*amplitude];
            end 
        end    
    case {'unipolar'}
        %disp('Method is unipolar')
        for count=1:length(input),
            for tempTime=0:Ts:Tb-Ts,
                output=[output input(count)*amplitude];
            end
        end
    case {'polar'}
        %disp('Method is polar')
        for count=1:length(input),
            for tempTime=0:Ts:Tb-Ts,
                output=[output amplitude*(-1)^(1+input(count))];
            end
        end
    otherwise,
        disp('NRZ_Encoder(input,Rb,amplitude,style)-Unknown method given as ''style'' argument');
        disp('Accepted Styles are ''Manchester'', ''Unipolar'' and ''Polar''');
end
time=0:Ts:Tb*length(input)-Ts;