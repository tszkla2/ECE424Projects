%Part of code used from MATLAB samples online
vidReader = VideoReader('viptraffic.avi');
while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    frameGray = rgb2gray(frameRGB);
    imshow(frameGray);
    hold on
end