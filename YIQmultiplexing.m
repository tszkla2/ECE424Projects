function [composite_video,I_Q]=YIQmultiplexing(Yraster,Iraster,Qraster,fc)

%QAM multiplexing of I and Q
%maximum Y frequency  fy=30*240*352/2*0.7=0.887 MHz
%choose carrier frequency fc=30*240/2*225=0.81 MHz
%there are 112.5 cyles per line

%sampling interval=1/30*352*240
%digital frequency =fc*sampling_interval=0.3196
%2*pi*fc*sampling_interval=2.0081

Fs=30*352*240; %sampling rate
fcd=fc/Fs; %digital frequency (1/Fs is sampling interval)
w=2*pi*fcd;
n=0:1:352*240-1;
wn=w*n;

%implementing QAM modulation
QAM=Iraster.*cos(wn)+Qraster.*sin(wn);


I_Q=QAM;

%multiplex Y and QAM
composite_video=Yraster+QAM;


