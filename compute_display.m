% image1 = im2single(imread('motorcycle.jpg')); 
% imagesc(log(abs(fftshift(fft2(image1)))))
% image2 = im2single(imread('high_frequencies.jpg')); 
% imagesc(log(abs(fftshift(fft2(image2)))))
% image3 = im2single(imread('low_frequencies.jpg')); 
% imagesc(log(abs(fftshift(fft2(image3)))))
image3 = im2single(imread('low_frequencies.jpg')); 
imagesc(log(abs(fftshift(fft2(image3)))));