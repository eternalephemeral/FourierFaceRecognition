% Face Recognition Using Fourier Transforms
% 
% Patrick Wang
% 
% Computes the overall recognition rate for our algorithm. Tests each of
% the 400 images against the other images (all except for the one being
% tested). Each test consists of computing the 'diff' value between the
% test image and a sample image and returning the sample image with the
% lowest diff value.
% 
% Several approaches to caluculating the 'diff' value are used:
% 
% METHOD
% 1. Euclidean distance of the real freqs
% 2. Euclidean distance of the [real, imag] freqs combined
% 3. Sum of the euclidean distances of the real/imag freqs separately
%
%                                         Method
%                                   1         2         3
% 
% With Padding (default):       0.9400    0.9800    0.9800
% Without Padding:              0.9375    0.9650    0.9650
% 
% <15 real, 12 imag> (default): 0.9400    0.9800    0.9800
% <22 real,  8 imag>:           0.9575    0.9750    0.9725
% < 5 real,  5 imag>:           0.7425    0.9450    0.9400
% 
% Rotation by  10 degrees:      0.7650    0.9150    0.9050
% Rotation by  30 degrees:      0.1150    0.2075    0.2150
% Rotation by  90 degrees:      0.0700    0.0450    0.0500
% Rotation by 180 degrees:      0.9350    0.0700    0.2000
% 

correctMatches = [0,0,0]; %for each of the 4 methods

for i=1:numSubjects
    for j=1:numFacesPerSubject        
        img = imread([mastDir, '\s', num2str(i), '\', num2str(j), '.pgm']);
        img = double(img)/255;                
        
        tImg = (i-1)*numFacesPerSubject + j;
        tFreq = face{tImg}.freq;        %normal case
        %tFreq = calcFreqID(img, 90);    %rotate case
        
        
        sampleImages = face;
        sampleImages(tImg) = []; %delete testImage from the 400 samples

        bestMatch = [0,0,0];
        lowestDiff = [Inf,Inf,Inf];
        for k=1:size(sampleImages,2)
            sFreq = sampleImages{k}.freq;
            
      
            diff(1) = norm(sFreq.r - tFreq.r);
            diff(2) = norm([sFreq.r, sFreq.i] - [tFreq.r, tFreq.i]);
            diff(3) = norm(sFreq.r - tFreq.r) + norm(sFreq.i - tFreq.i);
            
            for m=1:3
                if (diff(m) < lowestDiff(m))
                    lowestDiff(m) = diff(m);
                    bestMatch(m) = k;
                end
            end
        end
        
        for m=1:3        
            if (i == sampleImages{bestMatch(m)}.subject)
                correctMatches(m) = correctMatches(m) + 1;
            else
%                 if (m==2)
%                     disp([i,j]);    %images with incorrect match
%                 end
            end
        end
    end
end

recRate = correctMatches./(numSubjects*numFacesPerSubject);
disp(recRate);