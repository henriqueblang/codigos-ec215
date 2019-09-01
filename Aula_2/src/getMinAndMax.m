function [lowest, highest] = getMinAndMax(array)
lowest = 1;
highest = 0;

[lines, columns, pages] = size(array);

for i = 1:lines
    for j = 1:columns
        for k = 1:pages
            element = array(i, j, k);
            
            if element > highest
                highest = element;
            end
            
            if element < lowest
                lowest = element;
            end
        end
    end
end
end
                