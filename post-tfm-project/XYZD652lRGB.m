function ImagelRGB = XYZD652lRGB(ImageXYZD65)
%Input is XYZD65 and output lRGB 
%Sources https://en.wikipedia.org/wiki/SRGB
%        https://www.w3.org/Graphics/Color/srgb

ImageXYZD65 = double(ImageXYZD65);
[a b c] = size(ImageXYZD65);
ImagelRGB = ImageXYZD65;

%Uso la inversa de la matriz que se usa en lRGB2XYZD65
Matriz = inv([0.4124 0.3576 0.1805;
              0.2126 0.7152 0.0722;
              0.0193 0.1192 0.9505]);
      
for i=1:1:a
    for j=1:1:b
        %[i j]
        %[ImagelRGB(i,j,1);ImagelRGB(i,j,2);ImagelRGB(i,j,3)]
        %Matriz
        %Aplicamos la matriz de transformación
        %Matriz*[ImagelRGB(i,j,1);ImagelRGB(i,j,2);ImagelRGB(i,j,3)]
        ImagelRGB(i,j,:) = Matriz*[ImageXYZD65(i,j,1);ImageXYZD65(i,j,2);ImageXYZD65(i,j,3)];
        %pause
    end
end


end

