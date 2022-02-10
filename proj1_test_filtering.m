
close all
picture_name = 'bird';
picture_format = '.bmp';

test_image = im2single(imread(strcat('bird.png')));  
figure(1)
imshow(test_image)
title('original image');

identity_filter = [0 0 0; 0 1 0; 0 0 0];

identity_image  = my_imfilter(test_image, identity_filter);

figure(2); imshow(identity_image);
title('center=1');
mkdir(strcat('../data/', picture_name));
imwrite(identity_image, strcat('../data/', picture_name, '/identity_image.jpg'), 'quality', 95);

blur_filter = [1 1 1; 1 1 1; 1 1 1];
blur_filter = blur_filter / sum(sum(blur_filter)); %making the filter sum to 1

blur_image = my_imfilter(test_image, blur_filter);

figure(3); imshow(blur_image);
title('small blur image');
imwrite(blur_image, strcat('../data/', picture_name, '/small_blur_image.jpg'), 'quality', 95);


large_1d_blur_filter = fspecial('Gaussian', [25 1], 10);

large_blur_image = my_imfilter(test_image, large_1d_blur_filter);
large_blur_image = my_imfilter(large_blur_image, large_1d_blur_filter'); 

figure(4); imshow(large_blur_image);
title('Gaussian blur');
imwrite(large_blur_image, strcat('../data/', picture_name, '/Gaussian_blur_image.jpg'), 'quality', 95);

sobel_filter = [-1 0 1; -2 0 2; -1 0 1]; %should respond to horizontal gradients

sobel_image = my_imfilter(test_image, sobel_filter);

figure(5); imshow(sobel_image + 0.5);
title('sobel operator');
imwrite(sobel_image + 0.5, strcat('../data/', picture_name, '/sobel_image.jpg'), 'quality', 95);

laplacian_filter = [0 1 0; 1 -4 1; 0 1 0];

laplacian_image = my_imfilter(test_image, laplacian_filter);

figure(6); imshow(laplacian_image + 0.5);
title('laplacian image');
imwrite(laplacian_image + 0.5, strcat('../data/', picture_name, '/laplacian_image.jpg'), 'quality', 95);

high_pass_image = test_image - large_blur_image; %simply subtract the low frequency content

figure(7); imshow(high_pass_image+0.5);
title('simply sub low-frequencies');
imwrite(high_pass_image + 0.5, strcat('../data/', picture_name, '/simply_high_pass_image.jpg'), 'quality', 95);
