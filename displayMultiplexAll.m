function displayMultiplexAll(composite_video,QAM,Fs,F,Yraster,Iraster,Qraster,YP,IP,QP)
%plot waveforms of I, Q, and QAM I+Q
subplot(1,3,1),plot([0:1/Fs:352*1/Fs-1/Fs],Iraster(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('I Waveform')
axis ([0,1.5E-4,-80,80]);
subplot(1,3,2),plot([0:1/Fs:352*1/Fs-1/Fs],Qraster(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Q Waveform')
axis ([0,1.5E-4,-80,80]);

subplot(1,3,3),plot([0:1/Fs:352*1/Fs-1/Fs],QAM(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('QAM multiplexed I & Q')
axis ([0,1.5E-4,-80,80]);

%plot spectrum of I, Q, and QAM I+Q
figure;
subplot(1,3,1);semilogy(F,IP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('I Spectrum');
subplot(1,3,2);semilogy(F,QP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('Q Spectrum')
[QAMP,F]=spectrum(QAM,352*10,0,hanning(352*10),Fs);
subplot(1,3,3);semilogy(F,QAMP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('QAM I+Q Spectrum')


%plot waveform
figure;
subplot(1,2,1),plot([0:1/Fs:352*1/Fs-1/Fs],Yraster(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Y Waveform')
subplot(1,2,2),plot([0:1/Fs:352*1/Fs-1/Fs],composite_video(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Composite Waveform')

%plot spectrum
figure;
subplot(1,2,1);semilogy(F,YP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Y Spectrum')
[videoP,F]=spectrum(composite_video,352*10,0,hanning(352*10),Fs);
subplot(1,2,2);semilogy(F,videoP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Composite Video Spectrum')

%detailed view
figure;
subplot(1,2,1);semilogy(F,videoP(:,1));
axis([0,30*240*25,1E2,1E6])
title('Composite Spectrum (beginning)');

subplot(1,2,2);semilogy(F,videoP(:,1));
axis([30*240*200/2,30*240*250/2,1E2,1E6])
title('Composite Spectrum (near f_c)');

%view composite video as a monochrome signl
Yframe1_nofilt=col2im(composite_video(1:352*240),[1 1],[352 240])';
figure;
imshow(uint8(Yframe1_nofilt));
title('Image seen by B/W TV without filtering');



