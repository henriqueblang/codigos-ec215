% Padrão para encontrar as amostras do HDR.
fileName = '../images/SiW_%d.jpg';

% Quantidade de imagens com extensão .jpg no diretório de imagens.
% Para este exemplo, foram usados 5 amostras.
% Se o script for executado novamente, delete a imagem resultante do HDR anterior.
fileCount = size(dir(['../images/*.jpg']), 1);

hdrImage = 0;

for i = 1:fileCount
	hdrImage = hdrImage + double(imread(sprintf(fileName, i)));
end

hdrImage = hdrImage / fileCount;
hdrImage = uint8(hdrImage);

imshow(hdrImage);
imwrite(hdrImage, '../images/SiW_HDR.jpg');