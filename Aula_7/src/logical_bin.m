clear;
clc;

image1 = imread('../images/scene1.gif');
image2 = imread('../images/scene2.gif');

[height width channels] = size(image1);

threshold = 60;

image1Bin = zeros(height, width);
image2Bin = zeros(height, width);

for i = 1:height
    for j = 1:width
        image1Pixel = image1(i, j);
        image2Pixel = image2(i, j);
        
        % Para uma visualização melhor dos resultados, adota-se a atribuição do
        % branco para pixels com iluminação menor que o limiar.
        if image1Pixel > threshold
            image1Bin(i, j) = 0;
        else
            image1Bin(i, j) = 255;
        end    
            
        if image2Pixel > threshold
            image2Bin(i, j) = 0;
        else
            image2Bin(i, j) = 255;  
        end   
        
    end
end

image1Bin = uint8(image1Bin);
image2Bin = uint8(image2Bin);

figure(1);
imshow(image1Bin);
imwrite(image1Bin, '../images/scene1_binary.jpg');

figure(2);
imshow(image2Bin);
imwrite(image2Bin, '../images/scene2_binary.jpg');

% NOT (complemento)

image1Not = bitcmp(image1Bin);

figure(3);
imshow(image1Not);
imwrite(image1Not, '../images/scene1_binary_not.jpg');

image2Not = bitcmp(image2Bin);

figure(4);
imshow(image2Not);
imwrite(image2Not, '../images/scene2_binary_not.jpg');

% AND

image12And = bitand(image1Bin, image2Bin);

figure(5);
imshow(image12And);
imwrite(image12And, '../images/scene12_binary_and.jpg');

% AND (máscara)

% Inicializando a máscara com 0 (ocultar).
mask = zeros(height, width);

% Atribuindo 255 (manter) aos pixels na região entre as linhas 206 a 306 e
% colunas entre 206 a 306.
mask(206:306, 206:306) = 255;

mask = uint8(mask);

figure(6);
imshow(mask);
imwrite(mask, '../images/mask.jpg');

image1Mask = bitand(image1Bin, mask);

figure(7);
imshow(image1Mask);
imwrite(image1Mask, '../images/scene1_binary_mask.jpg');

image2Mask = bitand(image2Bin, mask);

figure(8);
imshow(image2Mask);
imwrite(image2Mask, '../images/scene2_binary_mask.jpg');

% OR

image12Or = bitor(image1Bin, image2Bin);

figure(9);
imshow(image12Or);
imwrite(image12Or, '../images/scene12_binary_or.jpg');

% XOR

image12Xor = bitxor(image1Bin, image2Bin);

figure(10);
imshow(image12Xor);
imwrite(image12Xor, '../images/scene12_binary_xor.jpg');









