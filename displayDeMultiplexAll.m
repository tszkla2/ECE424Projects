function displayDeMultiplexAll(video2QAM,composite_video,QAM,Fs,F,QAM2I_noflt,QAM2Q_noflt,video_LPF,QAM2I,QAM2Q,Yframe,Iframe,Qframe,Yraster,Iraster,Qraster,YP,IP,QP)

%plot spectrum
figure;
[QAMP,F1]=spectrum(QAM,352*10,0,hanning(352*10),Fs);
subplot(1,2,1);semilogy(F1,QAMP(:,1));
axis ([0,13E5,1E2,1E6]);
title('QAM Spectrum')
[video2QAMP,F1]=spectrum(video2QAM,352*10,0,hanning(352*10),Fs);
subplot(1,2,2);semilogy(F1,video2QAMP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Extracted QAM Spectrum')


%plot waveform
figure;
subplot(1,2,1),plot([0:1/Fs:352*1/Fs-1/Fs],QAM(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('QAM Waveform');axis([0,1.5E-4,-80,80]);
subplot(1,2,2),plot([0:1/Fs:352*1/Fs-1/Fs],video2QAM(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Demultiplexed QAM');axis([0,1.5E-4,-80,80]);
fprintf('QAM DeModulation.......\nPress any key to continue..\n');
pause;
close all;


%view composite video as a monochrome signl
video2Y_frame=col2im(video_LPF(1:352*240),[1 1],[352 240])';
figure;
imshow(uint8(video2Y_frame));
title('Image seen by B/W TV with filtering');


%plot spectrum
figure;
subplot(1,2,1);semilogy(F,YP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Y Spectrum')
[videoLPFP,F1]=spectrum(video_LPF,352*10,0,hanning(352*10),Fs);
subplot(1,2,2);semilogy(F1,videoLPFP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Extracted Y Spectrum')

%plot waveform
figure;
subplot(1,3,1),plot([0:1/Fs:352*1/Fs-1/Fs],Yraster(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Y Waveform');axis([0,1.5E-4,0,256]);
subplot(1,3,2),plot([0:1/Fs:352*1/Fs-1/Fs],composite_video(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Composite Waveform');axis([0,1.5E-4,0,256]);
subplot(1,3,3),plot([0:1/Fs:352*1/Fs-1/Fs],video_LPF(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Y from Composite using LPF');axis([0,1.5E-4,0,256]);

fprintf('QAM DeModulation (Y Component).......\nPress any key to continue..\n');
pause;
close all;


figure;
subplot(1,3,1),plot([0:1/Fs:352*1/Fs-1/Fs],Qraster(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Original I');axis([0,1.5E-4,-80,80]);
subplot(1,3,2),plot([0:1/Fs:352*1/Fs-1/Fs],QAM2I_noflt(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Demodulated I');axis([0,1.5E-4,-80,80]);
subplot(1,3,3),plot([0:1/Fs:352*1/Fs-1/Fs],QAM2I(1:352*1));
ylabel('Gray Level');
xlabel('Time');
title('Demodulation+LPF I');axis([0,1.5E-4,-80,80]);

%view extracted I as a monochrome signl
QAM2I_frame=col2im(QAM2I(1:352*240),[1 1],[352 240])';


%view extracted I as a monochrome signl
QAM2Q_frame=col2im(QAM2Q(1:352*240),[1 1],[352 240])';


figure;
subplot(2,2,1);imagesc(Iframe);title('original I');colormap(gray);
subplot(2,2,2);imagesc(Qframe);title('original Q');
subplot(2,2,3);imagesc(QAM2I_frame);title('Recovered I');
subplot(2,2,4);imagesc(QAM2Q_frame);title('Recovered Q');

figure;
subplot(1,3,1);semilogy(F,IP(:,1));
axis ([0,13E5,1E2,1E6]);
title('I Spectrum')
[QAM2I_nofltP,F1]=spectrum(QAM2I_noflt,352*10,0,hanning(352*10),Fs);
subplot(1,3,2);semilogy(F1,QAM2I_nofltP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Extracted I Spectrum w/o LPF');
[QAM2IP,F1]=spectrum(QAM2I,352*10,0,hanning(352*10),Fs);
subplot(1,3,3);semilogy(F1,QAM2IP(:,1));
axis ([0,13E5,1E2,1E6]);
title('Extracted I Spectrum after LPF');
fprintf('QAM DeModulation (I,Q Component).......\nPress any key to continue...\n');
pause;
close all;

