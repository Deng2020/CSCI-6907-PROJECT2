close all; 

image1 = im2single(imread('qingting.jfif')); 
image2 = im2single(imread('hybrid_bird_plane.jpg'));  

cutoff_frequency = 13;

filter = fspecial('Gaussian', [cutoff_frequency*4+1 1], cutoff_frequency);

low_frequencies = my_imfilter(my_imfilter(image1, filter), filter');

high_frequencies = image2 - my_imfilter(my_imfilter(image2, filter), filter');


hybrid_image = low_frequencies + high_frequencies;


subplot(2,3,1)
imshow(image1);
title('image1');

subplot(2,3,2)
imshow(low_frequencies);
title('low frequencies');

subplot(2,3,4)
imshow(image2);
title('image2');

subplot(2,3,5)
imshow(high_frequencies+0.5);
title('high frequencies');

subplot(2,3,[3 6])
imshow(hybrid_image);
title('hybrid image');

vis = vis_hybrid_image(hybrid_image);
figure(2); imshow(vis);
title('hybrid image downsampling:');

imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);
