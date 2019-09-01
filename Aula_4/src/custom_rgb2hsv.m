function hsv_img = custom_rgb2hsv(img)

%{
    Para conferir o resultado, reverta-o para RGB usando a função
    nativa do Matlab hsv2rgb e exiba a imagem.
    A faixa dos valores é de 0 a 1 para possibilitar a reversão da
    imagem com a função hsv2rgb.
    
    Exemplo de uso:
    
    img = imread('imagem.png');
    img_em_hsv = custom_rgb2hsv(img);
    imshow(hsv2rgb(img_em_hsv))
%}

[rows columns pages] = size(img);

for i = 1:rows
    for j = 1:columns
        % Iterando pixel a pixel.
        
        red = double(img(i, j, 1));
        green = double(img(i, j, 2));
        blue = double(img(i, j, 3));
        
        maxValue = double(max(img(i, j, :)));
        minValue = double(min(img(i, j, :)));
        
        delta = maxValue - minValue;
        
        V = maxValue;
        
        % Para evitar divisão por 0.
        if delta == 0  
            H = 0;
            S = 0;
        else
            if maxValue == red
                if green >= blue
                    H = 60 * ((green - blue) / delta);
                else
                    H = 60 * ((green - blue) / delta) + 360;
                end
            elseif maxValue == green
                H = 60 * ((blue - red) / delta) + 120;
            elseif maxValue == blue
                H = 60 * ((red - green) / delta) + 240;
            end
            
            S = delta / maxValue;
        end
  
        hsv_img(i, j, 1) = H / 360;   % Faixa de 0 a 1.
        hsv_img(i, j, 2) = S;         % Faixa de 0 a 1.
        hsv_img(i, j, 3) = V / 255;   % Faixa de 0 a 1.
    end
end

end
