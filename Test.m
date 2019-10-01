%Part of code used from MATLAB samples online
sample = VideoReader('viptraffic.avi');

Frames = 20;    %Which final frames of the video

sampleF = sample.NumberOfFrames;
sampleW = sample.Width;
sampleH = sample.Height;
sample = read(sample);

R = sample(:,:,1,sampleF-Frames+1:sampleF);
G = sample(:,:,2,sampleF-Frames+1:sampleF);
B = sample(:,:,3,sampleF-Frames+1:sampleF);
sample = 0.299*R+0.587*G+0.114*B;
sample = reshape(sample,sampleH,sampleW,Frames);

pixelW = 10;     %How many pixles are scanned on X axis
pixelH = 10;     %How many pixles are scanned on Y axis
region = 3;     %How many surrounding pixles are accounted for

XPixels = floor(sampleW/pixelW);
YPixels = floor(sampleH/pixelH);
totalPixels = YPixels*XPixels;

Pixels = uint8(zeros([pixelH pixelW totalPixels]));
pointer = zeros([2 totalPixels]);
final = uint8(zeros([sampleH sampleW Frames-1]));

for i=1:Frames-1
    newPixel = sample(:,:,i);
    for x = 1:YPixels
        for y = 1:XPixels
            Pixels(:,:,(x-1)*XPixels+mod(y-1,XPixels+1)+1) = sample((x-1)*pixelH+1:x*pixelH,(y-1)*pixelW+1:y*pixelW,i);
        end
        
    end
    
for j = 1:totalPixels
    nextX = mod(j-1,XPixels)*pixelW+1;
    nextY = floor((j-1)/XPixels)*pixelH+1;
    prevPixel = newPixel;
    minimum = inf;
    for x = nextY-region:nextY+region
        for y = nextX-region:nextX+region
            if (x<1)
                firstI = 1;
                firstPixelI = (1-x)+1;
            else
                firstI = x;
                firstPixelI = 1;
            end
            
            if (y<1)
                firstJ = 1;
                firstPixelJ = (1-y)+1;
            else
                firstJ = y;
                firstPixelJ = 1;
            end
            
            if (x+pixelH-1>sampleH)
                lastI = sampleH;
                lastPixelI = (sampleH-x)+1;
            else
                lastI = (x+pixelH)-1;
                lastPixelI = pixelH;
            end
              
            if (y+pixelW-1>sampleW)
                lastJ = sampleW;
                lastPixelJ = (sampleW-y)+1;
            else
                lastJ = (y+pixelW)-1;
                lastPixelJ = pixelW;
            end
            
            numPixels = (lastI-firstI+1)*(lastJ-firstJ+1);
            MSE = sum(sum(abs(Pixels(firstPixelI:lastPixelI,firstPixelJ:lastPixelJ,j)-sample(firstI:lastI,firstJ:lastJ,i+1)).^2));
            MSE = MSE/numPixels;
            if (numPixels>0&&MSE<minimum)
                minimum = MSE;
                newPixel = prevPixel;
                newPixel(firstI:lastI,firstJ:lastJ) = Pixels(firstPixelI:lastPixelI,firstPixelJ:lastPixelJ,j);
                pointer(1,j) = x;
                pointer(2,j) = y;
            end
            
        end
        
    end
    
final(:,:,i) = newPixel;
end

end

implay(final);
