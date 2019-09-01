myImg = imread('../images/party.jpg');

[height width channels] = size(myImg);

% Binária com método Average e limiar = 60

threshold = 60;
binaryImg = zeros(height, width);

for i = 1:height
	for j = 1:width
		red = double(myImg(i, j, 1));
		green = double(myImg(i, j, 2));
		blue = double(myImg(i, j, 3));
		
		avg = (red + green + blue) / 3;
		
		if avg > threshold
			binaryImg(i, j) = 255;
		end
	end
end

binaryImg = uint8(binaryImg);

imshow(binaryImg);
imwrite(binaryImg, '../images/party_binary.jpg');