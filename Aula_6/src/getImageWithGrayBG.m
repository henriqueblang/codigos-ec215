function grayBG = getImageWithGrayBG(image)
    height = size(image, 1);
    width = size(image, 2);
    
    newHeight = floor(height * 1.5);
    newWidth = floor(width * 1.5);
    
    grayBG = ones(newHeight, newWidth, 3);
    grayBG = grayBG * 127;
    
    startX = floor((newWidth - width) / 2);
    startY = floor((newHeight - height) / 2);
    
    for i = 1:height
        for j = 1:width
            grayBG(i + startY, j + startX, :) = image(i, j, :);
        end
    end
    
    grayBG = uint8(grayBG);
end
