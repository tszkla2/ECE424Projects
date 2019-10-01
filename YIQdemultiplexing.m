function [Yraster2,Iraster2,Qraster2,video2QAM,QAM2I_noflt,QAM2Q_noflt]=YIQdemultiplexing(composite_video,f_LPF1,f_LPF2,fc)

%filter the composite signal with low pass filter

%filter design
%cut-off frequency f_LPF=30*240/2*180=0.648
%with NTSC f_LPF=3,fc=3.58, f_LPF/fc=0.8380
%with our choice f_LPF=0.648,fc=0.81, f_LPF/fc=0.8025

Fs=30*352*240; %sampling rate
fcd=fc/Fs; %digital frequency (1/Fs is sampling interval)
w=2*pi*fcd;
n=0:1:352*240-1;
wn=w*n;

f_LPF=f_LPF1; 
%chose this number to realize response at f=0.648=-25dB,at 0.81=-50dB
fir_length=20;
LPF=fir1(fir_length,f_LPF/(Fs/2));
figure;
plot(LPF);
figure;
freqz(LPF,1,256,Fs);

%filter the data

video_LPF_shift=conv(composite_video,LPF);
video_LPF=video_LPF_shift(11:352*240+10);
Yraster2=video_LPF;

%extract QAM I and Q
video2QAM=composite_video-video_LPF;


%QAM demodulation

QAM2I_noflt=video2QAM.*cos(wn)*2;
QAM2Q_noflt=video2QAM.*sin(wn)*2;


%filter design
%cut-off frequency f_LPF=0.25MHz
%with NTSC f_LPF=3,fc=3.58, f_LPF/fc=0.8380
%with our choice f_LPF=0.648,fc=0.81, f_LPF/fc=0.8025
f_LPF=f_LPF2; 

fir_length=20;
LPF=fir1(fir_length,f_LPF/(Fs/2));
figure;
plot(LPF);
figure;
freqz(LPF,1,256,Fs);


%filter the data

QAM2I_shift=conv(QAM2I_noflt,LPF);
QAM2I=QAM2I_shift(11:352*240+10);
Iraster2=QAM2I;

QAM2Q_shift=conv(QAM2Q_noflt,LPF);
QAM2Q=QAM2Q_shift(11:352*240+10);
Qraster2=QAM2Q;



