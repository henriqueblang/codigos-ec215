%% Espelhamento na imagem inteira

mario = imread('../images/mario.png');

[height width channels] = size(mario);

% Espelhamento em X (ou seja, o eixo X age como um espelho)

for i = 1:height
	for j = 1:width
		x = j;
		y = i;
		
		newX = (width - x) + 1;
		newY = y;
		
		mirroredAllMarioInX(newY, newX, :) = mario(y, x, :);
	end
end

mirroredAllMarioInX = uint8(mirroredAllMarioInX);

% Espelhamento em Y (ou seja, o eixo Y age como um espelho)

for i = 1:height
	for j = 1:width
		x = j;
		y = i;
		
		newX = x;
		newY = (height - y) + 1;
		
		mirroredAllMarioInY(newY, newX, :) = mario(y, x, :);
	end
end

mirroredAllMarioInY = uint8(mirroredAllMarioInY);

figure(1);
imshow(mirroredAllMarioInX);
imwrite(mirroredAllMarioInX, '../images/all_mario_mirrored_x.jpg');

figure(2);
imshow(mirroredAllMarioInY);
imwrite(mirroredAllMarioInY, '../images/all_mario_mirrored_y.jpg');

%% Espelhamento em uma parte da imagem (neste exemplo, será a parte com fundo branco que contém o Mario)

marioGray = imread('../images/mario_gray_background.jpg');
[height width channels] = size(marioGray);

START_MARIO_X = 60;
END_MARIO_X = 299;

START_MARIO_Y = 60;
END_MARIO_Y = 299;

% Colocar fundo cinza do tamanho da imagem original, evidenciando assim a mudança de dimensionamento.
mirroredMarioInX = 127 * ones(height, width, channels);
mirroredMarioInY = 127 * ones(height, width, channels);

% Espelhamento em X (ou seja, o eixo X age como um espelho)

for i = START_MARIO_Y:END_MARIO_Y
	for j = START_MARIO_X:END_MARIO_X
		x = j;
		y = i;
		
		newX = (width - x) + 1;
		newY = y;
		
		mirroredMarioInX(newY, newX, :) = marioGray(y, x, :);
	end
end

mirroredMarioInX = uint8(mirroredMarioInX);

% Espelhamento em Y (ou seja, o eixo Y age como um espelho)

for i = START_MARIO_Y:END_MARIO_Y
	for j = START_MARIO_X:END_MARIO_X
		x = j;
		y = i;
		
		newX = x;
		newY = (height - y) + 1;
		
		mirroredMarioInY(newY, newX, :) = marioGray(y, x, :);
	end
end

mirroredMarioInY = uint8(mirroredMarioInY);

figure(3);
imshow(mirroredMarioInX);
imwrite(mirroredMarioInX, '../images/mario_mirrored_x.jpg');

figure(4);
imshow(mirroredMarioInY);
imwrite(mirroredMarioInY, '../images/mario_mirrored_y.jpg');