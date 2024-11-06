function compCode = CompeteCode(image,gabor)

[imageRows, imageCols] = size(image);
% imageRows = 128;
% imageCols = 128;
outRows = imageRows + 34;
outCols = imageCols + 34;

imageFFT = fft2(image, outRows, outCols);
GaborResponses(imageRows,imageCols,6) = 0;

for oriIndex = 1:6
    convRes = ifft2(imageFFT .* gabor(:,:,oriIndex));
    rawGaborRes = convRes((outRows - imageRows)/2 + 1 : (outRows - imageRows)/2 + imageRows,...
                                           (outCols - imageCols)/2 + 1 : (outCols - imageCols)/2 + imageCols);
    GaborResponses(:,:,oriIndex) = rawGaborRes;
end

[minValue, minIndex] = min(GaborResponses,[],3);
compCode = minIndex ;


