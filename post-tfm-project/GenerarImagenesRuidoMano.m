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
% JND calculated in the TFM
Jnd = [0.001109, 0.003179, 0.006551, 0.009895, 0.001517, 0.002611, 0.004158, 0.005681, 0.001995, 0.001421, 0.001045, 0.000944, 0.004554, 0.004944, 0.004783, 0.004452] 
%Now we create all the pair comparison matrix as a 5D matrix
%For each one of the 16 references we will make 1 pair comparisons
DataExperimentJNDsNoiseFlatBG = zeros(300,300,3,16,2,'uint8');
Index = 1;
for ref=1:1:16
    %Add noise in lRGB space and move to DeviceRGB coordinates
    DataExperimentJNDsNoiseFlatBG(:,:,:,ref,1) = lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),NoiseRefVector(ref)));
    imwrite(lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),NoiseRefVector(ref))), 'image_'+ref+'_without_incremented_noise.jpg');
    DataExperimentJNDsNoiseFlatBG(:,:,:,ref,2) = lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),(NoiseRefVector(ref) + Jnd(ref))));
    imwrite(lRGB2sRGB(AddGaussianNoiselRGB(ImagesBGlRGB(:,:,:,ref),(NoiseRefVector(ref) + Jnd(ref)))), 'image_'+ref+'_with_incremented_noise.jpg');
end

save('DataExperimentJNDsNoiseFlatBG.mat','DataExperimentJNDsNoiseFlatBG')








