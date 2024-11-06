import os
import numpy as np
import cv2
import random

def load_images_from_folder(folder, sample_percentage=1.0):
    images = []
    if not os.path.exists(folder):
        print(f"Error: Folder '{folder}' does not exist.")
        return np.array(images)

    all_files = sorted([f for f in os.listdir(folder) if f.endswith(".bmp")])
    sample_size = max(1, int(len(all_files) * sample_percentage)) 
    sampled_files = random.sample(all_files, sample_size)

    for filename in sampled_files:
        img_path = os.path.join(folder, filename)
        img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
        if img is not None:
            img = cv2.resize(img, (128, 128)) 
            images.append(img / 255.0) 
        else:
            print(f"Warning: Image at {img_path} could not be loaded.")

    if not images:
        print(f"Warning: No images were loaded from '{folder}'. Check file formats and folder contents.")
    return np.array(images)


def load_gallery_and_probe(gallery_folder, probe_folder):
    print(f"Loading gallery and probe images from '{gallery_folder}' and '{probe_folder}'...")
    gallery_images = load_images_from_folder(gallery_folder, sample_percentage=1.0)
    print("Gallery images shape:", gallery_images.shape)
    probe_images = load_images_from_folder(probe_folder, sample_percentage=1.0)
    print("Probe images shape:", probe_images.shape)
    return gallery_images, probe_images
