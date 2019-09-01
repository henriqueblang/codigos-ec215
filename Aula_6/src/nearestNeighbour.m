function scaledImage = nearestNeighbour(image, scale)
    [height width pages] = size(image);
    
    newHeight = height * scale;
    newWidth = width * scale;
    
    scaledImage = zeros(newHeight, newWidth, pages);
    
    for i = 1:newHeight
        for j = 1:newWidth
            originalImgX = round(j / scale);
            originalImgY = round(i / scale);
            
            if originalImgX == 0
                originalImgX = 1;
            elseif originalImgX > width
                originalImgX = width;
            end
        
            if originalImgY == 0
                originalImgY = 1;
            elseif originalImgY > height
                originalImgY = height;
            end

            scaledImage(i, j, :) = image(originalImgY, originalImgX, :);
        end
    end
    
    scaledImage = uint8(scaledImage);
end
