function decompressed = REPELIDA(encoded)
    % Reconstructive Efficient Pseudo-Empiric Lossy Image Decompression Algorithm
    
    height = size(encoded, 1);
    
    for i = 1:height
        column = 1;
        rowAnalyzed = encoded{i};
        width = size(rowAnalyzed, 2);
        total = 0;
        
        for j = 1:4:width 
            sequence = rowAnalyzed(j);  
            color = [rowAnalyzed(j + 1) rowAnalyzed(j + 2) rowAnalyzed(j + 3)];
            
            decompressed(i, column:(column + sequence - 1), 1) = color(1); 
            decompressed(i, column:(column + sequence - 1), 2) = color(2); 
            decompressed(i, column:(column + sequence - 1), 3) = color(3);   
            column += sequence;
        end  

    end
    
    decompressed = uint8(decompressed);
    
end
