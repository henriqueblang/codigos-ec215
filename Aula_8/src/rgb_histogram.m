clear;
clc;

image = imread('../images/tanjiro.jpg');

[height width channels] = size(image);

histogramRed = zeros(1, 256);
histogramGreen = zeros(1, 256);
histogramBlue = zeros(1, 256);

for i = 1:height
    for j = 1:width
        intensityRed = double(image(i, j, 1)) + 1;
        intensityGreen = double(image(i, j, 2)) + 1;
        intensityBlue = double(image(i, j, 3)) + 1;
        
        histogramRed(intensityRed) = histogramRed(intensityRed) + 1;
        histogramGreen(intensityGreen) = histogramGreen(intensityGreen) + 1;
        histogramBlue(intensityBlue) = histogramBlue(intensityBlue) + 1;
    end
end

% Mostrar apenas histograma vermelho.
figure(1);
bar(histogramRed, 'r');

% Mostrar apenas histograma verde.
figure(2);
bar(histogramGreen, 'g');

% Mostrar apenas histograma azul.
figure(3);
bar(histogramBlue, 'b');

% Mostrar todos os histogramas juntos.
figure(4);
bar(histogramRed, 'r');
hold on
bar(histogramGreen, 'g');
bar(histogramBlue, 'b');

saveas(figure(4), '../images/tanjiro_histogram.jpg');