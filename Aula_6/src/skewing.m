bx = 0.3;
by = 0.4;

%% Cisalhamento na imagem inteira

mario = imread('../images/mario.png');

[height width channels] = size(mario);

for i = 1:height
	for j = 1:width
		x = j;
		y = i;
		
		newX = uint16(x + bx * y);
		newY = uint16(y + by * x);
		
		skewedAllMario(newY, newX, :) = mario(y, x, :);
	end
end

skewedAllMario = uint8(skewedAllMario);

figure(1);
imshow(skewedAllMario);
imwrite(skewedAllMario, '../images/all_mario_skewed.jpg');


%% Cisalhamento em uma parte da imagem (neste exemplo, será a parte com fundo branco que contém o Mario)

marioGray = imread('../images/mario_gray_background.jpg');
[height width channels] = size(marioGray);

START_MARIO_X = 60;
END_MARIO_X = 299;

START_MARIO_Y = 60;
END_MARIO_Y = 299;

% Colocar fundo cinza do tamanho da imagem original, evidenciando assim a mudança de dimensionamento.
skewedMario = 127 * ones(height, width, channels);

for i = START_MARIO_Y:END_MARIO_Y
	for j = START_MARIO_X:END_MARIO_X
		x = j;
		y = i;
		
		newX = uint16(x + bx * y);
		newY = uint16(y + by * x);
		
		skewedMario(newY, newX, :) = marioGray(y, x, :);
	end
end

skewedMario = uint8(skewedMario);

figure(2);
imshow(skewedMario);
imwrite(skewedMario, '../images/mario_skewed.jpg');
