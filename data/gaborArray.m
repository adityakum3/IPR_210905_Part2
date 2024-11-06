function gabor = gaborArray(ROISize, sigma,wavelength,ratio)
 
% Bounding box
halfLength = 17;

xmax = halfLength;
xmin = -halfLength; 
ymax = halfLength;
ymin = -halfLength;
[x,y] = meshgrid(xmin:xmax,ymin:ymax);

outRows = ROISize + 34;
outCols = ROISize + 34;

mask = ones(35, 35);
for row = 1:35
    for col = 1:35
        if (row - 18)^2 + (col - 18)^2 > 289
            mask(row,col) = 0;
        end
    end
end

for oriIndex = 1:6
    theta = pi / 6 * (oriIndex - 1);
    % Rotation 
    x_theta=x*cos(theta)+y*sin(theta);
    y_theta=-x*sin(theta)+y*cos(theta);

    %gb = exp(-.5*((x_theta.^2 + y_theta.^2)/sigma^2)).*cos(2*pi/lambda*x_theta);
    gb=exp(-.5*(x_theta.^2/sigma^2+y_theta.^2/(ratio * sigma)^2)).*cos(2*pi/wavelength*x_theta);
    
    total = sum(sum(gb.*mask));
    meanInner = total / sum(sum(mask));
    
    gb = gb - mean2(meanInner);
    gb = gb .* mask;
    gbFFT = fft2(gb, outRows, outCols);
    gabor(:,:,oriIndex) = gbFFT;
end
