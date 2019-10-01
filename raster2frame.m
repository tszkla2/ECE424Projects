function [Yframe2,Iframe2,Qframe2]=raster2frame(Yraster2,Iraster2,Qraster2)

Yframe2=col2im(Yraster2,[1 1],[352 240])';
Iframe2=col2im(Iraster2,[1 1],[352 240])';
Qframe2=col2im(Qraster2,[1 1],[352 240])';

