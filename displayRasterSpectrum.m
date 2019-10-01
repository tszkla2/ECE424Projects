function [YP,IP,QP,F]=displayRasterSpectrum(Yraster,Iraster,Qraster,Fs)
figure;
%using FFT window size of 10 lines to compute the spectrum
%when using 1 line only, does not show the periodic structure
%when using 20 lines, not enough averaging, more noisy then 10 lines
[YP,F]=spectrum(Yraster,352*10,0,hanning(352*10),Fs);
subplot(1,3,1);semilogy(F,YP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('Y Spectrum')
[IP,F]=spectrum(Iraster,352*10,0,hanning(352*10),Fs);
subplot(1,3,2);semilogy(F,IP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('I Spectrum')
[QP,F]=spectrum(Qraster,352*10,0,hanning(352*10),Fs);
subplot(1,3,3);semilogy(F,QP(:,1));
axis ([0,13E5,1E-1,1E6]);
title('Q Spectrum')
