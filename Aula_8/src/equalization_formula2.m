clear;
clc;

% https://www.math.uci.edu/icamp/courses/math77c/demos/hist_eq.pdf

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

% Frequência relativa dos pixels.
relativeHistogram = histogram;
totalPixels = height * width;

for i = 1:numel(relativeHistogram)
    relativeHistogram(i) = histogram(i) / totalPixels;
end    
   
% Frequência relativa cumulativa dos pixels.
cRelative = zeros(1, 256);

cRelative(1) = relativeHistogram(1);

for i = 2:numel(relativeHistogram)
    cRelative(i) = relativeHistogram(i) +  cRelative(i - 1);
end

% Inicializar imagem equalizada.
eqImg = zeros(height, width);

% Número de intensidades de pixel.
L = 256;

for i = 1:height
    for j = 1:width
        intensity = image(i, j) + 1;
        
        eqImg(i, j) = floor((L - 1) * cRelative(intensity));
    end
end

eqImg = uint8(eqImg);

figure(2);
imshow(eqImg);

imwrite(eqImg, '../images/hill_equalized_2.jpg');
