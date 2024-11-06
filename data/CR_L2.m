function recognitionRate = CR_L2(patchSize,lambda, sigma,ratio,wavelength)

ROISize = 128;
gabor = gaborArray(ROISize,sigma,wavelength,ratio);
%Create the dictionary matrix A from gallery samples
dic = generateDictionary( patchSize,ROISize,gabor);

%Classification use CRC_RLS and get the recognition rate
recognitionRate = CRC_RLS(dic, patchSize, gabor,lambda);

