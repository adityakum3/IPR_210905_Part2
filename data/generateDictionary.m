%this script is used to generate the dictionary from all the 3D palmprint
%ROIs; each column of the dictionary matrix actually is a feature vector
function dic = generateDictionary(patchSize,ROISize,gabor)

%the following dir contains ROI images for the first capturing session. It
%may need to be changed based on your local data path
ROIFiles = dir('E:\standard code & dataset\Datasets\TongjiContactlessPalmprint\ROI\session1\*.bmp');
oriFeatureDim = (floor(ROISize/patchSize))^2 * 6; %the points near the boundary were not used
features = zeros(oriFeatureDim,length(ROIFiles));

parfor roiIndex = 1:length(ROIFiles)
    currentRefFileName = ['E:\standard code & dataset\Datasets\TongjiContactlessPalmprint\ROI\session1\' ROIFiles(roiIndex).name];
    im = double(imread(currentRefFileName));
    
    featureVector = createCCFeature(im, gabor, patchSize);
    features(:,roiIndex) = featureVector;
end

dic = features;
%each column should be normalized
for colIndex = 1:size(dic, 2)
    colNorm = norm(dic(:,colIndex)); %each column should have a unit l2-norm
    dic(:,colIndex) = dic(:,colIndex)/colNorm; 
end