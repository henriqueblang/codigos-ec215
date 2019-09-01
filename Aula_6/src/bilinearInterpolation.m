function scaledImage = bilinearInterpolation(image, scale)
    height = size(image, 1);
    width = size(image, 2);
    
    newHeight = height * scale;
    newWidth = width * scale;
    
    for i = 1:newHeight
        for j = 1:newWidth
            x = j;
            y = i;
            
            % Dividir pela escala é o mesmo que multiplicar pelo fator.
            subPixelX = x / scale;
            subPixelY = y / scale;
            
            integerPartX = floor(subPixelX);
            integerPartY = floor(subPixelY);
            
            diffX = subPixelX - integerPartX;
            diffY = subPixelY - integerPartY;
            
            if integerPartX < 1
                integerPartX = 1;
            elseif integerPartX > width - 1
                integerPartX = width - 1;
            end
            
            if integerPartY < 1
                integerPartY = 1;
            elseif integerPartY > height - 1
                integerPartY = height - 1;
            end
            
            scaledImage(i, j, :) = image(integerPartY, integerPartX, :) * (1 - diffY) * (1 - diffX);
            scaledImage(i, j, :) = scaledImage(i, j, :) + image(integerPartY + 1, integerPartX, :) * diffY * (1 - diffX);
            scaledImage(i, j, :) = scaledImage(i, j, :) + image(integerPartY, integerPartX + 1, :) * (1 - diffY) * diffX;
            scaledImage(i, j, :) = scaledImage(i, j, :) + image(integerPartY + 1, integerPartX, :) * diffY * diffX;
        end
    end
    
    scaledImage = uint8(scaledImage);
end
