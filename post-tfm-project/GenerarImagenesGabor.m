%Generate backgrounds
%Frecuencies to study: 4, 8, 12 and 16 cycles per degree of visual angle
%Compute CSF for those frecuencies. Using expression for YC1C2 color space
f=0.5, CSF_lum_a = 0.63*f^0.616*exp(-0.085*f)
f=2, CSF_lum_b = 0.63*f^0.616*exp(-0.085*f)
f=5, CSF_lum_c = 0.63*f^0.616*exp(-0.085*f)
f=8, CSF_lum_d = 0.63*f^0.616*exp(-0.085*f)

%Define contrast for gabor patches
Contrast = 0.19;
%Adapt contrast with CSF for each frecuency so that perceived contrast is
%equal for all gabor patches
Contrastfa = Contrast/CSF_lum_a
Contrastfb = Contrast/CSF_lum_b
Contrastfc = Contrast/CSF_lum_c
Contrastfd = Contrast/CSF_lum_d

%Generate gabor patches. 4 cases
%We generate in YC1C2 color space which is the color space for the CSF
%above
%First case 4 cycles per degree of visual angle
%Measure and compute degree of visual angles per image
ImageSize = 400; %pixels
ImageLength = 8.5; %cm
VDistance = 50; %cm
dvaperImage = 2*atan((ImageLength/2)/VDistance)*180/pi;
cyclesperdva = 0.5; %for the case of 4 cycles per dva
cyclesperImage = dvaperImage*cyclesperdva; 
PixelsperCycle = ImageSize/cyclesperImage;
%lambda input is the number of pixels per cycle
[x y ImageBG1YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,0,0.5+Contrastfa/2,0.5-Contrastfa/2,0,0,0,0);
[x y ImageBG2YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/4,0.5+Contrastfa/2,0.5-Contrastfa/2,0,0,0,0);
[x y ImageBG3YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/2,0.5+Contrastfa/2,0.5-Contrastfa/2,0,0,0,0);
ImageBG1lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG1YC1C2));
ImageBG2lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG2YC1C2));
ImageBG3lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG3YC1C2));

%cycles per degree of visual angle
cyclesperdva = 2; 
cyclesperImage = dvaperImage*cyclesperdva; 
PixelsperCycle = ImageSize/cyclesperImage;
%lambda input is the number of pixels per cycle
[x y ImageBG4YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,0,0.5+Contrastfb/2,0.5-Contrastfb/2,0,0,0,0);
[x y ImageBG5YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/4,0.5+Contrastfb/2,0.5-Contrastfb/2,0,0,0,0);
[x y ImageBG6YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/2,0.5+Contrastfb/2,0.5-Contrastfb/2,0,0,0,0);
ImageBG4lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG4YC1C2));
ImageBG5lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG5YC1C2));
ImageBG6lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG6YC1C2));

%cycles per degree of visual angle
cyclesperdva = 5; 
cyclesperImage = dvaperImage*cyclesperdva; 
PixelsperCycle = ImageSize/cyclesperImage;
%lambda input is the number of pixels per cycle
[x y ImageBG7YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,0,0.5+Contrastfc/2,0.5-Contrastfc/2,0,0,0,0);
[x y ImageBG8YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/4,0.5+Contrastfc/2,0.5-Contrastfc/2,0,0,0,0);
[x y ImageBG9YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/2,0.5+Contrastfc/2,0.5-Contrastfc/2,0,0,0,0);
ImageBG7lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG7YC1C2));
ImageBG8lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG8YC1C2));
ImageBG9lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG9YC1C2));

%cycles per degree of visual angle
cyclesperdva = 8; 
cyclesperImage = dvaperImage*cyclesperdva; 
PixelsperCycle = ImageSize/cyclesperImage;
%lambda input is the number of pixels per cycle
[x y ImageBG10YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,0,0.5+Contrastfd/2,0.5-Contrastfd/2,0,0,0,0);
[x y ImageBG11YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/4,0.5+Contrastfd/2,0.5-Contrastfd/2,0,0,0,0);
[x y ImageBG12YC1C2] = gaborpatch(ImageSize,ImageSize,PixelsperCycle,pi/2,0.5+Contrastfd/2,0.5-Contrastfd/2,0,0,0,0);
ImageBG10lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG10YC1C2));
ImageBG11lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG11YC1C2));
ImageBG12lRGB = XYZD652lRGB(YC1C22XYZD65(ImageBG12YC1C2));

%figure,imshow(uint8(ImageBG1lRGB))

%%
%Now we have 12 background images to add noise to

%Put reference images in 4d Matrix adding noise
%Noise levels reference: 0.01 0.02 0.04 0.08
ImagesBGlRGB = zeros(400,400,3,4*4); %4 backgrounds and 4 noise levels make 16 reference images 
ImagesBGlRGB(:,:,:,1) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,2) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,3) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,4) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,5) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,6) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,7) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,8) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,9) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,10) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,11) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,12) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,13) = ImageBG5lRGB;
ImagesBGlRGB(:,:,:,14) = ImageBG5lRGB;
ImagesBGlRGB(:,:,:,15) = ImageBG5lRGB;
ImagesBGlRGB(:,:,:,16) = ImageBG6lRGB;
ImagesBGlRGB(:,:,:,17) = ImageBG6lRGB;
ImagesBGlRGB(:,:,:,18) = ImageBG6lRGB;
ImagesBGlRGB(:,:,:,19) = ImageBG7lRGB;
ImagesBGlRGB(:,:,:,20) = ImageBG7lRGB;
ImagesBGlRGB(:,:,:,21) = ImageBG7lRGB;
ImagesBGlRGB(:,:,:,22) = ImageBG8lRGB;
ImagesBGlRGB(:,:,:,23) = ImageBG8lRGB;
ImagesBGlRGB(:,:,:,24) = ImageBG8lRGB;
ImagesBGlRGB(:,:,:,25) = ImageBG9lRGB;
ImagesBGlRGB(:,:,:,26) = ImageBG9lRGB;
ImagesBGlRGB(:,:,:,27) = ImageBG9lRGB;
ImagesBGlRGB(:,:,:,28) = ImageBG10lRGB;
ImagesBGlRGB(:,:,:,29) = ImageBG10lRGB;
ImagesBGlRGB(:,:,:,30) = ImageBG10lRGB;
ImagesBGlRGB(:,:,:,31) = ImageBG11lRGB;
ImagesBGlRGB(:,:,:,32) = ImageBG11lRGB;
ImagesBGlRGB(:,:,:,33) = ImageBG11lRGB;
ImagesBGlRGB(:,:,:,34) = ImageBG12lRGB;
ImagesBGlRGB(:,:,:,35) = ImageBG12lRGB;
ImagesBGlRGB(:,:,:,36) = ImageBG12lRGB;
%Noise to be added to each reference
NoiseRefVector = [0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08 0.02 0.04 0.08]
%add more noise to higher frequency 
%K factor to define the constant stimuli in relation to each noise and can
%be changed for each frequency
NoiseRefK = [ 0.025 0.025 0.025 0.025 0.025 0.025 0.025 0.025 0.025 0.045 0.040 0.040 0.040 0.035 0.035 0.040 0.035 0.030 0.045 0.045 0.035 0.045 0.045 0.035 0.045 0.040 0.035 0.065 0.050 0.050 0.065 0.050 0.050 0.065 0.050 0.050] 
%Now we create all the pair comparison matrix as a 5D matrix
%For each one of the 16 references we will make 10 pair comparisons
DataExperimentJNDsNoiseGaborPatches = zeros(400,400,3,36*10,2,'uint8');
Index = 1;
ruidos = [];
for ref=1:1:36
    for test=1:1:10
        ruidos = [ruidos; NoiseRefVector(ref) NoiseRefK(ref)*NoiseRefVector(ref) (NoiseRefVector(ref) + test*((NoiseRefK(ref)*NoiseRefVector(ref))))];
        %Add noise in lRGB space and move to DeviceRGB coordinates
        %and add Gaussian envelope
        DataExperimentJNDsNoiseGaborPatches(:,:,:,Index,1) = XYZ2DeviceRGB(sRGB2XYZD65(lRGB2sRGB(gaussianfilter(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),NoiseRefVector(ref)),90,[0.5 0.5 0.5]))));
        DataExperimentJNDsNoiseGaborPatches(:,:,:,Index,2) = XYZ2DeviceRGB(sRGB2XYZD65(lRGB2sRGB(gaussianfilter(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),(NoiseRefVector(ref) + test*(NoiseRefK(ref)*NoiseRefVector(ref)))),90,[0.5 0.5 0.5]))));
        Index = Index+1;
        Ready = (Index/360)*100
    end
end
%separate for different sessions
save('DataExperimentJNDsNoiseGaborPatches.mat','DataExperimentJNDsNoiseGaborPatches')








