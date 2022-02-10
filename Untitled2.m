
clear all;

d0=50;  %阈值
image=imread('path.jfif');
[M ,N]=size(image);

img_f = fft2(double(image));%傅里叶变换得到频谱
img_f=fftshift(img_f);  %移到中间

m_mid=floor(M/2);%中心点坐标
n_mid=floor(N/2);  

h = zeros(M,N);%高斯低通滤波器构造
for i = 1:M
    for j = 1:N
        d = ((i-m_mid)^2+(j-n_mid)^2);
        h(i,j) = exp(-(d)/(2*(d0^2)));      
    end
end

img_lpf = h.*img_f;

img_lpf=ifftshift(img_lpf);    %中心平移回原来状态
img_lpf=uint8(real(ifft2(img_lpf)));  %反傅里叶变换,取实数部分

subplot(1,2,1);imshow(image);title('原图');
subplot(1,2,2);imshow(img_lpf);title('高斯低通滤波d=50');

