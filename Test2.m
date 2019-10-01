%Part of code used from MATLAB samples online
videoFileReader = vision.VideoFileReader('visionface.avi');
videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
objectFrame = step(videoFileReader);
objectRegion = [264,122,93,93];
points = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',objectRegion);
pointImage = insertMarker(objectFrame,points.Location,'+','Color','white');
tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,points.Location,objectFrame);
while ~isDone(videoFileReader)
      frame = step(videoFileReader);
      [points,validity] = step(tracker,frame);
      out = insertMarker(frame,points(validity, :),'+');
      step(videoPlayer,out);
end
release(videoPlayer);
release(videoFileReader);