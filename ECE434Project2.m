%Part of code used from MATLAB samples online
vidReader = VideoReader('viptraffic.avi');
opticFlow = opticalFlowHS;
while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    frameGray = rgb2gray(frameRGB);
    flow = estimateFlow(opticFlow,frameGray); 
    imshow(frameGray) 
    hold on
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',25)
    hold off 
end
