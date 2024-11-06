%this is the source code for the contactless palmprint identification
%method, namely CR_CompCode
%Lin Zhang, School of Software Engineering, Tongji University

patchSize = 14; %patch size for computing local histograms
lambda = 1.35; %a parameter used in solving CRC_RLS

sigma = 4.85; %used for generating Gabor filter
ratio = 1.92; %sigma's ratio used for generating Gabor filter
wavelength = 14.1; %used for generating Gabor filter

rr = CR_L2(patchSize, lambda,sigma, ratio,wavelength);
