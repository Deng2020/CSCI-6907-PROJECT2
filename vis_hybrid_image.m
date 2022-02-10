function output = vis_hybrid_image(hybrid_image)
%% 成倍缩小4次混合图像，最后的结果output是一张图，方便从不同距离观察结果，白色区域是用零填充的

%对混合图像进行下采样
%下采样又称缩小图像
scales = 5; %缩小4次
scale_factor = 0.5; %每次缩小2倍
padding = 5; %填充5个像素用于图片间隔

original_height = size(hybrid_image,1); %图像的行数
num_colors = size(hybrid_image,3); %图像的通道数
output = hybrid_image; 
cur_image = hybrid_image;

for i = 2:scales  %缩小4次
    %填充5列像素，2指按行合并两个矩阵
    %填充的像素值是1（白色）
    output = cat(2, output, ones(original_height, padding, num_colors));
    %imresize命令是下采样操作。将cur_image缩小1/scale_factor倍，bilinear采用双线性插值法
    %双线性插值法：https://www.cnblogs.com/snow826520/p/9267837.html
    cur_image = imresize(cur_image, scale_factor, 'bilinear');
    %1指按列合并两个矩阵，上面是白色，下面是缩小后的图
    tmp = cat(1,ones(original_height - size(cur_image,1), size(cur_image,2), num_colors), cur_image);
    %将前一output和此时缩小图tmp按行合并
    output = cat(2, output, tmp); 
end