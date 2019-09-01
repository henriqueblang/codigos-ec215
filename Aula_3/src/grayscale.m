myImg = imread('../images/party.jpg');

[height width channels] = size(myImg);

% Grayscale com Lightness

for i = 1:height
	for j = 1:width
		red = double(myImg(i, j, 1));
		green = double(myImg(i, j, 2));
		blue = double(myImg(i, j, 3));
		
		maxChannel = max([red green blue]);
		minChannel = min([red green blue]);
		
		grayImage(i, j) = (maxChannel + minChannel) / 2;
	end
end

grayImage = uint8(grayImage);

imshow(grayImage);
imwrite(grayImage, '../images/party_grayscale.jpg');