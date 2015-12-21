% Face Recognition Using Fourier Transforms
%
% Patrick Wang
%
% Calculate the freqID (feature vector) for each image in the database
% through fourier analysis
%
% RUN THIS FIRST!

global mastDir numSubjects numFacesPerSubject numRVarFreq numIVarFreq padd face;

mastDir = 'att_faces';
numSubjects = 40;
numFacesPerSubject = 10;

numRVarFreq = 15;     %# of real freq's used for freqID, 15/22/5
numIVarFreq = 12;     %# of imag freq's used for freqID, 12/8/5
padd = 1;             %padd images or not?

for i = 1:numSubjects
    for j = 1:numFacesPerSubject
        img = imread([mastDir, '\s', num2str(i), '\', num2str(j), '.pgm']);
        img = double(img)/255;
        
        freq = calcFreqID(img, 0);
        face{(i-1)*numFacesPerSubject + j} = struct('subject', i, 'image', j, 'freq', freq);
    end
end








