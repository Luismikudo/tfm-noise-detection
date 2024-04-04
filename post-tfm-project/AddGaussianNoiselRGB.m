function NoisyImage=AddGaussianNoiselRGB(Image,Sigma)
%
%NoisyImage=AddGaussianNoiselRGB(Image,Sigma)
%
%Funcion que añade ruido gausiando de media 0 y desv. tip. SIGMA a IMAGE en
%el espacio lRGB en [0,1].
%

[a,b,c] = size(Image);
%Generamos matrices de ruido
RNoise = zeros(a,b);
GNoise = zeros(a,b);
BNoise = zeros(a,b);

RNoise = random('Normal',0,Sigma,a,b); 
GNoise = random('Normal',0,Sigma,a,b);
BNoise = random('Normal',0,Sigma,a,b);

NoisyImage=zeros(a,b,c);

%Sumamos matrices de ruido
NoisyImage(:,:,1) = Image(:,:,1)+RNoise;
NoisyImage(:,:,2) = Image(:,:,2)+GNoise;
NoisyImage(:,:,3) = Image(:,:,3)+BNoise;
         
for i=1:c
    for j=1:a
        for k=1:b
            if (NoisyImage(j,k,i)<0)
                NoisyImage(j,k,i)=0;
            elseif (NoisyImage(j,k,i)>1)
                NoisyImage(j,k,i)=1;
            end
        end
    end
end
