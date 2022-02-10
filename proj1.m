close all; 
%% 主函数流程：
%1.输入图像 设置参数 建立滤波算子
%2.对图1低通过滤，对图2高通过滤
%3.合成hybrid图片，输出结果(第一个窗口包括原图、低、高频图和混合图，第二个窗口是缩小图像尺寸的图)

%对齐操作
%[image1,image2]=alignment();

%% 输入图片
%imread返回图像类型是uint8，矩阵范围为0--255
%im2single将图片转换成单精度数，范围是0--1
image1 = im2single(imread('qingting.jfif')); 
image2 = im2single(imread('hybrid_bird_plane.jpg'));  

%% Filtering and Hybrid Image construction
%截止频率（高斯模糊的标准偏差），以像素为单位，当振幅增益gain=1/2时定义的频率
% cutoff_frequency = 13;
cutoff_frequency = 13;
%fspecial建立一个标准差为cutoff_frequency,尺寸为(cutoff*4+1,1)的滤波模板；
%原理公式可见：https://www.cnblogs.com/bingdaocaihong/p/7007346.html
%fspecial函数c语言实现：https://blog.csdn.net/xizero00/article/details/8595781
%其中：类型是高斯低通滤波、第二项是模板尺寸（一维滤波），第三项是滤波器的标准差，即截止频率
filter = fspecial('Gaussian', [cutoff_frequency*4+1 1], cutoff_frequency);

%对image1进行低通过滤，得到图1的低频部分
%low_frequencies= imfilter(image1, filter);
%卷积算子是对称矩阵，将其分解成一个矩阵与其转置的乘积
%先后与原图进行卷积，减少计算次数
low_frequencies = my_imfilter(my_imfilter(image1, filter), filter');

%得到图2的高频部分。对image2进行低通过滤，得到图2的低频部分，用image2减低频即为高频部分
%high_frequencies= image2-imfilter(image2, filter);
high_frequencies = image2 - my_imfilter(my_imfilter(image2, filter), filter');

%hybrid image（图1的低频+图2的高频）
hybrid_image = low_frequencies + high_frequencies;

%% 保存和输出结果
subplot(2,3,1)
imshow(image1);
title('image1');

%输出图1的低频部分
subplot(2,3,2)
imshow(low_frequencies);
title('low frequencies');

subplot(2,3,4)
imshow(image2);
title('image2');

%输出图2的低频部分
%imshow的数据范围是0--1
%high_frequencies+0.5的原因：
%原图四周较黑,高通过滤后，四周提取到的特征会很少，显示会很黑，影响观察结果
%加上0.5后便于观察（加合适的值也可以）
subplot(2,3,5)
imshow(high_frequencies+0.5);
title('high frequencies');

%显示混合图片
subplot(2,3,[3 6])
imshow(hybrid_image);
title('hybrid image');

%缩小显示混合图片，方便比对结果
vis = vis_hybrid_image(hybrid_image);
figure(2); imshow(vis);
title('hybrid image downsampling:');

%在当前目录保存结果为jpg文件
imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);
