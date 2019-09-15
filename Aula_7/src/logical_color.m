clear;
clc;

image1 = imread('../images/space1.jpg');
image2 = imread('../images/space2.jpg');

[height width channels] = size(image1);

% NOT (complemento)

image1Not = bitcmp(image1);

figure(3);
imshow(image1Not);
imwrite(image1Not, '../images/space1_not.jpg');

image2Not = bitcmp(image2);

figure(4);
imshow(image2Not);
imwrite(image2Not, '../images/space2_not.jpg');

% AND

image12And = bitand(image1, image2);

figure(5);
imshow(image12And);
imwrite(image12And, '../images/space12_and.jpg');

% AND (máscara)

% Inicializando a máscara com 0 (ocultar).
mask = zeros(height, width, channels);

% Atribuindo 255 (manter) aos pixels na região entre as linhas 200 a 700 e
% colunas entre 300 a 1200.
mask(200:700, 300:1200, :) = 255;

mask = uint8(mask);

figure(6);
imshow(mask);
imwrite(mask, '../images/mask.jpg');

image1Mask = bitand(image1, mask);

figure(7);
imshow(image1Mask);
imwrite(image1Mask, '../images/space1_mask.jpg');

image2Mask = bitand(image2, mask);

figure(8);
imshow(image2Mask);
imwrite(image2Mask, '../images/space2_mask.jpg');

% OR

image12Or = bitor(image1, image2);

figure(9);
imshow(image12Or);
imwrite(image12Or, '../images/space12_or.jpg');

% XOR

image12Xor = bitxor(image1, image2);

figure(10);
imshow(image12Xor);
imwrite(image12Xor, '../images/space12_xor.jpg');





