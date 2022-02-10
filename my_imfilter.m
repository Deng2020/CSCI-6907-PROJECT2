function output = my_imfilter(image, filter)
%% 过滤函数思路
%对边界采用0填充，将原图像按列排列，方便一维滤波做乘法，一维计算快
%for循环单独过滤每一个通道
%滤波模板滑到每一块的时候计算矩阵即可

%% 可以利用matlab内置函数imfilter直接一句搞定,不过低频部分特别特别模糊，结果不太好
    %output = imfilter(image, filter);
%为适用于彩色图像，只需独立过滤每个颜色通道。
%该过滤器适用于任何高度和宽度的组合，只要高度、宽度是奇数，那么中心像素的位置就是明确的。
%边界问题：用0填充
%%
intput_image = image;
%输入图片的行和列331*375
[intput_row, intput_col] = size(intput_image(:,:,1));
%过滤模板的行和列53*1
[filter_row, filter_col] = size(filter);

%padarray是填充函数，[r ,c]为填充尺寸 中间像素，大小为过滤器尺寸的一半
%无填充方法参数 默认用零填充；无填充方向参数 默认both:在每一维的第一个元素前和最后一个元素后填充
pad_input_image = padarray(intput_image, [(filter_row - 1)/2, (filter_col - 1)/2]);

output = [];

for layer = 1:size(intput_image, 3) % 独立过滤每一层通道
    % im2col将输入图像的行列按列展开，一块展开成是53个像素，53*1
    % 模板滑到的一块区域按列存储，方便和模板进行矩阵计算
    columns = im2col(pad_input_image(:,:,layer), [filter_row, filter_col]);
    
    % transpose是转置函数
    filter2 = transpose(filter(:));
    
    % 矩阵乘法，滤波模板乘以每一列，得到的就是输出图像
    filterd_columns = filter2 * columns;
    
    % col2im是从列恢复到原图像尺寸
    output(:,:,layer) = col2im(filterd_columns, [1, 1], [intput_row, intput_col]);
end