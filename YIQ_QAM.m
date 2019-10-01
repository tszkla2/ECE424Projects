%Programs for extracting sample frames from a interlaced sequence in YCbCr color coordinate, 
%down-sample Y to get progressive frames
%Convert YCbCr to YIQ
%covert to raster format for each component, perform multiplexing of I and Q using QAM
%multiplex  Y and QAM to get composite video
%demultiplexing using filtering and demodulation
%show both raster waveform and images and spectrum
%Assume the sequence is in MPEG420 format (704*480 Y pixels, 352*240 Cr/Cb pixels), saved in YUV format
%YUV format: save Y frame (480x704) first, followed by Cb (240x352), then Cr (240x352)
%Author:  Yao Wang 9/10/03
%fc=30*240/2*225;
%f_LPF1=30*240/2*150;
%f_LPF2=0.2E6;

filename=input('Please Input File Name: ','s');
fc=input('Please Input fc: ');
f_LPF1=input('Please Input f_LPF1: ');
f_LPF2=input('Please Input f_LPF2: ');
[Rframe,Gframe,Bframe,Yframe,Iframe,Qframe]=YCbCr2RGB2YIQ(filename,480,704,1);
displayRGB(Rframe,Gframe,Bframe);
title('Original color frame');

fprintf('Dispaly the current frame.......\nPress any key to continue...\n');
pause;
close all;

[Yraster,Iraster,Qraster]=frame2raster(Yframe,Iframe,Qframe);
Fs=30*352*240; %sampling rate
%compute and plot the spectrum
[YP,IP,QP,F]=displayRasterSpectrum(Yraster,Iraster,Qraster,Fs);

fprintf('Dispaly the 1-D raster signals and their spectrum.......\nPress any key to continue..\n');
pause;
close all;

[composite_video,QAM]=YIQmultiplexing(Yraster,Iraster,Qraster,fc);
displayMultiplexAll(composite_video,QAM,Fs,F,Yraster,Iraster,Qraster,YP,IP,QP)
fprintf('QAM Modulation.......\nPress any key to continue...\n');
pause;
close all;


[Yraster2,Iraster2,Qraster2,video2QAM,QAM2I_noflt,QAM2Q_noflt]=YIQdemultiplexing(composite_video,f_LPF1,f_LPF2,fc);
displayDeMultiplexAll(video2QAM,composite_video,QAM,Fs,F,QAM2I_noflt,QAM2Q_noflt,Yraster2,Iraster2,Qraster2,Yframe,Iframe,Qframe,Yraster,Iraster,Qraster,YP,IP,QP);


[Yframe2,Iframe2,Qframe2]=raster2frame(Yraster2,Iraster2,Qraster2);
%convert to RGB
Rframe2=Yframe2+0.956*Iframe2+0.620*Qframe2;
Gframe2=Yframe2-0.272*Iframe2-0.647*Qframe2;
Bframe2=Yframe2-1.108*Iframe2+1.7*Qframe2;

displayRGB(Rframe2,Gframe2,Bframe2);
title('Recovered color frame');

displayRGB(Rframe,Gframe,Bframe);
title('Original color frame');
