arr1 = rand(5, 5, 3);
arr2 = rand(5, 5, 3);

arr = arr1 .* arr2;

arr = arr / 2;

subArr = arr(:, 1:3, :);

retArr = [arr subArr];

retArr

[min, max] = getMinAndMax(retArr);

fprintf('Menor: %f, maior: %f\n', min, max);