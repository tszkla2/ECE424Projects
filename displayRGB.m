function displayRGB(Rframe,Gframe,Bframe)

rgbimage=zeros(240,352,3);
rgbimage(:,:,1)=Rframe;
rgbimage(:,:,2)=Gframe;
rgbimage(:,:,3)=Bframe;
figure;
imshow(uint8(rgbimage));
