%this script implements the classification of palmprints based on CRC_RLS
function recognitionRate = CRC_RLS(Dic, patchSize,gabor,lambda)
%the following dir contains ROI images for the seceond capturing session. It
%may need to be changed based on your local data path
ROIFiles = dir('E:\standard code & dataset\Datasets\TongjiContactlessPalmprint\ROI\session2\*.bmp');
classNOs = length(ROIFiles) / 10;
correctSamplesClassfied = 0;

numberOfSamples = size(Dic, 2);
P = inv(Dic' * Dic + lambda * eye(numberOfSamples)) * Dic';

parfor roiIndex = 1:length(ROIFiles)

    currentRefFileName = ['E:\standard code & dataset\Datasets\TongjiContactlessPalmprint\ROI\session2\' ROIFiles(roiIndex).name];
    im = double(imread(currentRefFileName));
    
    yFeatureVector = createCCFeature(im, gabor, patchSize);
    yFeatureVector = yFeatureVector/norm(yFeatureVector);

    x0 = P*yFeatureVector;
                       
    residual = [];
    for classIndex = 1:classNOs
        partialDic = Dic(:, (classIndex-1)*10+1:classIndex*10);
        partialX0 = x0((classIndex-1)*10+1:classIndex*10);
        residual(classIndex) = sum((partialDic*partialX0 - yFeatureVector).^2);
    end
    
    [~,classLabel] = min(residual);

    if classLabel == ceil(roiIndex/10)
        correctSamplesClassfied = correctSamplesClassfied + 1;
    end
end

recognitionRate = correctSamplesClassfied / length(ROIFiles);