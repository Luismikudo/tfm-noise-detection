%Backgrounds in Lab: (20|40|60|80,0,0)
%Compute coordinates in xyzd65
%BG1XYZD65 = lab2xyz([20 0 0],[0.9504 1.0000 1.0889]);
%BG2XYZD65 = lab2xyz([40 0 0],[0.9504 1.0000 1.0889]);
%BG3XYZD65 = lab2xyz([60 0 0],[0.9504 1.0000 1.0889]);
%BG4XYZD65 = lab2xyz([80 0 0],[0.9504 1.0000 1.0889]);

BG1XYZD65 = lab2xyz([20 0 0],'WhitePoint', [0.9504 1.0000 1.0889]);
BG2XYZD65 = lab2xyz([40 0 0],'WhitePoint', [0.9504 1.0000 1.0889]);
BG3XYZD65 = lab2xyz([60 0 0],'WhitePoint', [0.9504 1.0000 1.0889]);
BG4XYZD65 = lab2xyz([80 0 0],'WhitePoint', [0.9504 1.0000 1.0889]);

%Create Images
ImageBG1XYZD65 = zeros(300,300,3);
ImageBG1XYZD65(:,:,1) = BG1XYZD65(1);
ImageBG1XYZD65(:,:,2) = BG1XYZD65(2);
ImageBG1XYZD65(:,:,3) = BG1XYZD65(3);

ImageBG2XYZD65 = zeros(300,300,3);
ImageBG2XYZD65(:,:,1) = BG2XYZD65(1);
ImageBG2XYZD65(:,:,2) = BG2XYZD65(2);
ImageBG2XYZD65(:,:,3) = BG2XYZD65(3);

ImageBG3XYZD65 = zeros(300,300,3);
ImageBG3XYZD65(:,:,1) = BG3XYZD65(1);
ImageBG3XYZD65(:,:,2) = BG3XYZD65(2);
ImageBG3XYZD65(:,:,3) = BG3XYZD65(3);

ImageBG4XYZD65 = zeros(300,300,3);
ImageBG4XYZD65(:,:,1) = BG4XYZD65(1);
ImageBG4XYZD65(:,:,2) = BG4XYZD65(2);
ImageBG4XYZD65(:,:,3) = BG4XYZD65(3);

%Move to lRGB
ImageBG1lRGB = XYZD652lRGB(ImageBG1XYZD65);
ImageBG2lRGB = XYZD652lRGB(ImageBG2XYZD65);
ImageBG3lRGB = XYZD652lRGB(ImageBG3XYZD65);
ImageBG4lRGB = XYZD652lRGB(ImageBG4XYZD65);

%Put reference images in 4d Matrix adding noise
%Noise levels reference: 0.01 0.02 0.04 0.08
ImagesBGlRGB = zeros(300,300,3,4*4); %4 backgrounds and 4 noise levels make 16 reference images 
ImagesBGlRGB(:,:,:,1) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,2) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,3) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,4) = ImageBG1lRGB;
ImagesBGlRGB(:,:,:,5) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,6) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,7) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,8) = ImageBG2lRGB;
ImagesBGlRGB(:,:,:,9) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,10) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,11) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,12) = ImageBG3lRGB;
ImagesBGlRGB(:,:,:,13) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,14) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,15) = ImageBG4lRGB;
ImagesBGlRGB(:,:,:,16) = ImageBG4lRGB;
%Noise to be added to each reference
NoiseRefVector = [0.01 0.02 0.03 0.04 0.01 0.02 0.03 0.04 0.01 0.02 0.03 0.04 0.01 0.02 0.03 0.04] 
%K factor to define the constant stimuli in relation to each noise
%reference level
KRefVector = [0.026 0.029 0.029 0.028 0.033 0.028 0.027 0.025 0.036 0.034 0.032 0.030 0.038 0.033 0.033 0.033] 
%Now we create all the pair comparison matrix as a 5D matrix
%For each one of the 16 references we will make 10 pair comparisons
DataExperimentJNDsNoiseFlatBG = zeros(300,300,3,16*10,2,'uint8');
Index = 1;
ruidos = [];
for ref=1:1:16
    for test=1:1:10
        ruidos = [ruidos; NoiseRefVector(ref) KRefVector(ref)*NoiseRefVector(ref) (NoiseRefVector(ref) + test*((KRefVector(ref)*NoiseRefVector(ref))))];
        %Add noise in lRGB space and move to DeviceRGB coordinates
        DataExperimentJNDsNoiseFlatBG(:,:,:,Index,1) = lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),NoiseRefVector(ref)));
        DataExperimentJNDsNoiseFlatBG(:,:,:,Index,2) = lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),(NoiseRefVector(ref) + test*((KRefVector(ref)*NoiseRefVector(ref))))));
        Index = Index+1;
        Ready = round(Index/(16*10)*100)
    end
end

save('DataExperimentJNDsNoiseFlatBG.mat','DataExperimentJNDsNoiseFlatBG')








