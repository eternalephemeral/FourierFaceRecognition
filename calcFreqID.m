function freq= calcFreqID( img, rot)
% Calculates the freqID of img using the lower quadrant method
% Returns r_len real frequencies and i_len imag frequencies
% Options: padd & rot padds the image or rotates it prior to calculation
global numRVarFreq numIVarFreq padd;

    if (padd == 1)  %padd image so it is a square matrix with dim power of 2

        if (rot ~= 0)   %padd image twice the normal size, rotate image and crop the extra padding
            paddDim = 2^(ceil(log2(max(size(img))))+1);
            
            yPad = (paddDim - size(img,1))/2;
            xPad = (paddDim - size(img,2))/2;

            pimg = padarray(img,[yPad,xPad],'replicate');
            pimg = imrotate(pimg, rot, 'crop');
            
            yc = floor(size(pimg,1)/2);
            xc = floor(size(pimg,2)/2);
            off = paddDim/4;
            
            img = pimg( yc-off:yc+off , xc-off:xc+off );
        else    %no rotation
            paddDim = 2^ceil(log2(max(size(img))));

            yPad = (paddDim - size(img,1))/2;
            xPad = (paddDim - size(img,2))/2;

            img = padarray(img,[yPad,xPad],'replicate');
        end
    else
        if (rot ~= 0)   %rotate image by rot degrees
            img = imrotate(img, rot);
        end
    end
    
    %imshow(img);
    
    %Fourier analysis to determine the freqID of image for a particular
    %subject

    F = fft2(img);
    Freal = real(F);
    Fimag = imag(F);

    %Using the lower quadrant method to calculate real/imag components
    %of freqID
    MVF_R = diagTrav( Freal, numRVarFreq ); %most variant freq (real)
    MVF_I = diagTrav( Fimag, numIVarFreq ); %most variant freq (imag)

    MVF_R(1) = [];  %delete first entry for both real and imag freq's
    MVF_I(1) = [];

    freq = struct('r', MVF_R, 'i', MVF_I);

end

