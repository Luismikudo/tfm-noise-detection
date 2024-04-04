function ImagesRGB = lRGB2sRGB(ImagelRGB)
%Input is sRGB nonlinear and output XYZD65
%Sources https://en.wikipedia.org/wiki/SRGB
%        https://www.w3.org/Graphics/Color/srgb

ImagelRGB = double(ImagelRGB);
[a b c] = size(ImagelRGB);
ImagesRGB  = ImagelRGB;

for i=1:1:a
    for j=1:1:b
        %[i j]
        %[ImagesRGB(i,j,1);ImagesRGB(i,j,2);ImagesRGB(i,j,3)]
        %Gamma correction
        if (ImagelRGB(i,j,1)<0.0031308)
            ImagesRGB(i,j,1) = 12.92*ImagelRGB(i,j,1);
        else
            ImagesRGB(i,j,1) = 1.055*(ImagelRGB(i,j,1)^(1/2.4))-0.055;
        end
        if (ImagesRGB(i,j,2)<0.0031308)
            ImagesRGB(i,j,2) = 12.92*ImagelRGB(i,j,2);
        else
            ImagesRGB(i,j,2) = 1.055*(ImagelRGB(i,j,2)^(1/2.4))-0.055;
        end
        if (ImagesRGB(i,j,3)<0.0031308)
            ImagesRGB(i,j,3) = 12.92*ImagelRGB(i,j,3);
        else
            ImagesRGB(i,j,3) = 1.055*(ImagelRGB(i,j,3)^(1/2.4))-0.055;
        end
        ImagesRGB(i,j,:) = 255*ImagesRGB(i,j,:);
    end
end
ImagesRGB = uint8(ImagesRGB);


end

