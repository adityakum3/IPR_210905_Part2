from scipy.ndimage import convolve
import numpy as np

def gabor_filter(image, frequency, theta, sigma, delta, omega, kappa):
    x = np.linspace(-3 * sigma, 3 * sigma, int(6 * sigma))
    y = np.linspace(-3 * sigma, 3 * sigma, int(6 * sigma))
    X, Y = np.meshgrid(x, y)

    X_theta = X * np.cos(theta) + Y * np.sin(theta)
    Y_theta = -X * np.sin(theta) + Y * np.cos(theta)

    kernel = np.exp(- (X_theta**2 + delta**2 * Y_theta**2) / (2 * sigma**2)) * np.cos(2 * np.pi * frequency * X_theta)

    filtered_image = convolve(image, kernel)
    return filtered_image

def extract_features(images, frequencies, thetas, sigma=4.6, delta=2.6, omega=0.58, kappa=2.65):
    features = []
    for idx, img in enumerate(images):
        img_features = []
        print("Processing image", idx + 1)
        for f in frequencies:
            for t in thetas:
                filtered_img = gabor_filter(img, f, t, sigma=sigma, delta=delta, omega=omega, kappa=kappa)
                img_features.append(filtered_img.mean())
        features.append(img_features)
    return np.array(features)
