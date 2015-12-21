% Face Recognition Using Fourier Transforms
%
% Patrick Wang
%
% Compares img j of subject i with all other images in the database and returns the
% matching subject
function matchFace(i, j)
global mastDir numFacesPerSubject face;

img = imread([mastDir, '\s', num2str(i), '\', num2str(j), '.pgm']);
img = double(img)/255;

tImg = (i-1)*numFacesPerSubject + j;
tFreq = calcFreqID(img, 0);

sampleImages = face;
sampleImages(tImg) = []; %delete testImage from the 400 samples

bestMatch = 0;
lowestDiff = Inf;
for k=1:size(sampleImages,2)
    sFreq = sampleImages{k}.freq;
    
    diff = norm([sFreq.r, sFreq.i] - [tFreq.r, tFreq.i]);
    
    if (diff < lowestDiff)
        lowestDiff = diff;
        bestMatch = k;
    end
end

disp(['Image best matched with subject ', num2str(sampleImages{bestMatch}.subject)]);
end