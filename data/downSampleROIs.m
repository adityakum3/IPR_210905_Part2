%this script is used to sub-sample ROI files
%function downSampleROIs();
rootDir = '..\ROI\session1\';
desDir = '..\dsROI\session1\';
gau = fspecial('gaussian',5,1.5);
ROIFiles = dir([rootDir '*.bmp']);
for roiIndex = 1:length(ROIFiles)
    
        roiFileName = [rootDir ROIFiles(roiIndex).name];
        ROIimage = double(imread(roiFileName));
        convROIImage = imfilter(ROIimage,gau,'replicate');
        dsROIImage = convROIImage(1:2:end,1:2:end);

        desFileName = [desDir ROIFiles(roiIndex).name];

        imwrite(uint8(dsROIImage),desFileName);
end

rootDir = '..\ROI\session2\';
desDir = '..\dsROI\session2\';
gau = fspecial('gaussian',5,1.5);
ROIFiles = dir([rootDir '*.bmp']);
for roiIndex = 1:length(ROIFiles)
    
        roiFileName = [rootDir ROIFiles(roiIndex).name];
        ROIimage = double(imread(roiFileName));
        convROIImage = imfilter(ROIimage,gau,'replicate');
        dsROIImage = convROIImage(1:2:end,1:2:end);

        desFileName = [desDir ROIFiles(roiIndex).name];

        imwrite(uint8(dsROIImage),desFileName);
end