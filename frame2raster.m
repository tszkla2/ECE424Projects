function [Yraster,Iraster,Qraster]=frame2raster(Yframe,Iframe,Qframe)

%convert the frame data to a 1D vector (raster)
Yraster=im2col(Yframe',[1,1],'distinct');
Iraster=im2col(Iframe',[1,1],'distinct');
Qraster=im2col(Qframe',[1,1],'distinct');

%plot the raster waveform for first 5 lines

figure;
Fs=30*352*240; %sampling rate
subplot(1,3,1),plot([0:1/Fs:352*5/Fs-1/Fs],Yraster(1:352*5));
ylabel('Gray Level');
xlabel('Time');
title('Y Waveform')
axis ([0,7E-4,0,256]);
subplot(1,3,2),plot([0:1/Fs:352*5/Fs-1/Fs],Iraster(1:352*5));
ylabel('Gray Level');
xlabel('Time');
title('I Waveform')
axis ([0,7E-4,-128,128]);
subplot(1,3,3),plot([0:1/Fs:352*5/Fs-1/Fs],Qraster(1:352*5));
ylabel('Gray Level');
xlabel('Time');
title('Q Waveform')
axis ([0,7E-4,-128,128]);

