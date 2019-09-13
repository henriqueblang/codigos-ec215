clear;
clc;

image = imread('../images/hill.jpg');

[height width channels] = size(image);

% Histograma de 1 linha e 256 colunas, preenchido
% inicialmente com 0.
histogram = zeros(1, 256);

for i = 1:height
    for j = 1:width
        % Normalizar intensidade do pixel na faixa de
        % 1 a 256 para ser indexado no histograma. 
        intensity = double(image(i, j)) + 1;
        
        % Incrementar a quantidade de pixels com a
        % intensidade normalizada no histograma.
        histogram(intensity) = histogram(intensity) + 1;
    end
end

figure(1);
bar(histogram);

saveas(figure(1), '../images/hill_histogram.png');

% Inicializar histograma cumulativo.
cHistogram = zeros(1, 256);

cHistogram(1) = histogram(1);

for i = 2:numel(histogram);
    cHistogram(i) = histogram(i) + cHistogram(i - 1);
end

cHistogram(255)

% Inicializar imagem equalizada.
eqImg = zeros(height, width);

% Número de intensidades de pixel.
L = 256;

cHistogramMin = min(cHistogram);
for i = 1:height
    for j = 1:width
        intensity = image(i, j) + 1;
        
        eqImg(i, j) = round(((cHistogram(intensity) - cHistogramMin) / ((height * width) - cHistogramMin)) * (L - 1));
    end
end

eqImg = uint8(eqImg);

figure(2);
imshow(eqImg);

imwrite(eqImg, '../images/hill_equalized_1.jpg');
