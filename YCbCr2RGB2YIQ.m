function [Rframe,Gframe,Bframe,Yframe,Iframe,Qframe]=YCbCr2RGB2YIQ(filename,width,height,frameno)

FID = fopen(filename,'r');
%This sequence contains 4 frames of the sequence only
[tempY,count]=fread(FID,[height,width*3/2],'uint8');
fseek(FID,count*(frameno-1), -1);
%read 1 frame
[tempY,count]=fread(FID,[height,width*3/2],'uint8');

%extract Y component
tempY=tempY';
tempY1(1:480,:)=tempY(1:480,:);

%downsample tempY1 to be the same size as Cb and Cr
Yframe=zeros(240,352);
Yframe=(tempY1(1:2:480,1:2:704)+tempY1(1:2:480,2:2:704))/2;
%use averaging over the same line, but not across the lines because adjacent lines
%are from different fields.

%display frame1 Y
figure
imshow(uint8(Yframe));
title('Y component');


%extract Cb and Cr components
Cbframe=zeros(240,352);
Cbframe(1:2:240,1:352)=tempY(481:600,1:352);
Cbframe(2:2:240,1:352)=tempY(481:600,353:704);
figure
imshow(uint8(Cbframe));
title('Cb component');

Crframe=zeros(240,352);
Crframe(1:2:240,1:352)=tempY(601:720,1:352);
Crframe(2:2:240,1:352)=tempY(601:720,353:704);
figure
imshow(uint8(Crframe));
title('Cr component');


%convert to RGB color coordinate
Yframe=Yframe-16;
Cbframe=Cbframe-128;
Crframe=Crframe-128;
Rframe=1.164*Yframe+1.596*Crframe;
Gframe=1.164*Yframe-0.392*Cbframe-0.813*Crframe;
Bframe=1.164*Yframe+2.017*Cbframe;




%convert RGB to YIQ
Yframe=0.299*Rframe+0.587*Gframe+0.114*Bframe;
Iframe=0.596*Rframe-0.275*Gframe-0.321*Bframe;
Qframe=0.212*Rframe-0.523*Gframe+0.311*Bframe;


figure
imshow(uint8(Yframe));
title('Y component');

figure
imshow(uint8(Iframe+128));
title('I component');

figure
imshow(uint8(Qframe+128));
title('Q component');

fclose(FID);