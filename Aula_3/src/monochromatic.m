myImg = imread('../images/party.jpg');

[height width channels] = size(myImg);

% Monocromático (vermelho) com método Luminosity

monoImg = zeros(height, width, channels);

for i = 1:height
	for j = 1:width
		red = double(myImg(i, j, 1));
		green = double(myImg(i, j, 2));
		blue = double(myImg(i, j, 3));
		
		monoImg(i, j, 1) = 0.21 * red + 0.72 * green + 0.07 * blue;
	end
end

monoImg = uint8(monoImg);

imshow(monoImg);
imwrite(monoImg, '../images/party_monochromatic.jpg');
