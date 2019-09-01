mario = imread('../images/mario.png');

tic
imwrite(nearestNeighbour(mario, 5), '../images/mario5xNN.jpg');
toc

tic
imwrite(bilinearInterpolation(mario, 5), '../images/mario5xBI.jpg');
toc