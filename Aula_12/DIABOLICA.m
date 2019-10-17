function compressed = DIABOLICA(inputImage, blocks)
    % Deterministic Iterative Averaged Block-Oriented Lossy Image Compression Algorithm
    
    [height width channels] = size(inputImage);

    pixelsPerBlock = blocks * blocks;

    % Convert to LAB color space
    imageLab = rgb2lab(inputImage);

    resultImage = inputImage;

    for i = 1:blocks:height
        for j = 1:blocks:width
            
            endBlockVertical = i + (blocks - 1);
            endBlockHorizontal = j + (blocks - 1);
            
            if endBlockVertical > height || endBlockHorizontal > width
                continue
            end

            % Get block
            workingBlock = inputImage(i:endBlockVertical, j:endBlockHorizontal, :);
            workingBlockLab = imageLab(i:endBlockVertical, j:endBlockHorizontal, :);
           
            % Get mean pixel value of block
            blockSum = sum(sum(workingBlock));
            blockMeanRed = blockSum(1) / pixelsPerBlock;
            blockMeanGreen = blockSum(2) / pixelsPerBlock;
            blockMeanBlue = blockSum(3) / pixelsPerBlock;

            % Convert mean pixel value to LAB color space
            blockMeanLab = rgb2lab(blockMeanRed, blockMeanGreen, blockMeanBlue);

            % Get coordinates of highest color distance pixel from mean pixel
            [x y] = highestColorDistance(workingBlockLab, blockMeanLab);
           
            % Spread pixel color to block
            resultImage(i:endBlockVertical, j:endBlockHorizontal, :) = 1;
            resultImage(i:endBlockVertical, j:endBlockHorizontal, 1) *= double(workingBlock(y, x, 1));
            resultImage(i:endBlockVertical, j:endBlockHorizontal, 2) *= double(workingBlock(y, x, 2));
            resultImage(i:endBlockVertical, j:endBlockHorizontal, 3) *= double(workingBlock(y, x, 3));

        end
    end

    resultImage = uint8(resultImage);
    
    compressed = rle(resultImage);

end

function vec = mat2vec(mat)
    %MAT2VEC returns a line vector from a matrix
    vec = mat(:)';
end

function [x y] = highestColorDistance(array, cmp)

    height = size(array, 1);
    width = size(array, 2);
    
    x = -1;
    y = -1;
    highestDistance = -1;
    
    for i = 1:height
        for j = 1:width
            colorDistance = sqrt((array(i, j, 1) - cmp(1)) ^ 2 + (array(i, j, 2) - cmp(2)) ^ 2 + (array(i, j, 3) - cmp(3)) ^ 2);
            
            if colorDistance > highestDistance
                x = j;
                y = i;
                highestDistance = colorDistance;
            end
        end
    end
    
end

function compressed = rle(img)
    %RLE Run Length Encoding Compression
    [rows, columns, pages] = size(img);
    % use 'help cell' para entender melhor o cell array
    compressed = cell(rows, 1);

    for i = 1:rows
        % inicializa a linha com o primeiro pixel e a contagem = 0
        new_row = [];
        count = 0;
        current_color = mat2vec(img(i, 1, :));
        
        % percorre a linha
        for j = 1:columns
            % salva o pixel atual em um vetor linha
            aux_color = mat2vec(img(i, j, :));
            
            if aux_color ~= current_color
                % se o pixel atual for diferente dos anteriores, 
                % adiciona a contagem e o pixel anterior na nova linha
                new_row = [new_row, count, current_color];
                count = 1;
                current_color = aux_color;
            else
                % se for igual o pixel anterior, incrementa a contagem
                count = count + 1;
            end
        end
        
        % adiciona o ultimo pixel da linha e sua contagem
        new_row = [new_row, count, current_color];
        
        % salva a linha na posicao dela no resultado
        compressed{i} = new_row;
    end

end

function [L, a, b] = rgb2lab(R, G, B)
    %RGB2LAB Convert an image from RGB to CIELAB
    %
    % function [L, a, b] = rgb2lab(R, G, B)
    % function [L, a, b] = rgb2lab(I)
    % function I = rgb2lab(...)
    %
    % rgb2lab takes red, green, and blue matrices, or a single M x N x 3 image, 
    % and returns an image in the CIELAB color space.  RGB values can be
    % either between 0 and 1 or between 0 and 255.  Values for L are in the
    % range [0,100] while a and b are roughly in the range [-110,110].  The
    % output is of type double.
    %
    % This transform is based on ITU-R Recommendation BT.709 using the D65
    % white point reference. The error in transforming RGB -> Lab -> RGB is
    % approximately 10^-5.  
    %
    % See also LAB2RGB.
    % By Mark Ruzon from C code by Yossi Rubner, 23 September 1997.
    % Updated for MATLAB 5 28 January 1998.
    % Updated for MATLAB 7 30 March 2009.
    if nargin == 1
      B = double(R(:,:,3));
      G = double(R(:,:,2));
      R = double(R(:,:,1));
    end
    if max(max(R)) > 1.0 || max(max(G)) > 1.0 || max(max(B)) > 1.0
      R = double(R) / 255;
      G = double(G) / 255;
      B = double(B) / 255;
    end
    % Set a threshold
    T = 0.008856;
    [M, N] = size(R);
    s = M * N;
    RGB = [reshape(R,1,s); reshape(G,1,s); reshape(B,1,s)];
    % RGB to XYZ
    MAT = [0.412453 0.357580 0.180423;
           0.212671 0.715160 0.072169;
           0.019334 0.119193 0.950227];
    XYZ = MAT * RGB;
    % Normalize for D65 white point
    X = XYZ(1,:) / 0.950456;
    Y = XYZ(2,:);
    Z = XYZ(3,:) / 1.088754;
    XT = X > T;
    YT = Y > T;
    ZT = Z > T;
    Y3 = Y.^(1/3); 
    fX = XT .* X.^(1/3) + (~XT) .* (7.787 .* X + 16/116);
    fY = YT .* Y3 + (~YT) .* (7.787 .* Y + 16/116);
    fZ = ZT .* Z.^(1/3) + (~ZT) .* (7.787 .* Z + 16/116);
    L = reshape(YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 * Y), M, N);
    a = reshape(500 * (fX - fY), M, N);
    b = reshape(200 * (fY - fZ), M, N);
    if nargout < 2
      L = cat(3,L,a,b);
    end
end
    
