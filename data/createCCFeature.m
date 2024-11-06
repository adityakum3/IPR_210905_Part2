function ccFeatureVector = createCCFeature(im, gabor, patchSize)
%this function generates the feature vector for one palmprint ROI.

ccMap = CompeteCode(im,gabor);
rows = size(ccMap, 1);
patchesPerRow = floor(rows / patchSize);

ccMap = ccMap(floor((rows-patchesPerRow*patchSize)/2)+1:end-floor((rows-patchesPerRow*patchSize)/2), ...
    floor((rows-patchesPerRow*patchSize)/2)+1:end-floor((rows-patchesPerRow*patchSize)/2));

ccFeatureVector = [];
binCenter = 1:6; %because there are 6 possible compcode values
for patchRowIndex = 1:patchesPerRow
    for patchColIndex = 1:patchesPerRow
        currentPatch = ccMap((patchRowIndex-1) * patchSize + 1:patchRowIndex * patchSize,(patchColIndex-1) * patchSize+1:patchColIndex * patchSize);
        ccFeatureVector = [ccFeatureVector hist(currentPatch(:), binCenter) / (patchSize^2)];
    end
end
ccFeatureVector = ccFeatureVector';
