
clear all;

d0=50; 
image=imread('path.jfif');
[M ,N]=size(image);

img_f = fft2(double(image));
img_f=fftshift(img_f); 

m_mid=floor(M/2);%midlle point
n_mid=floor(N/2);  

h = zeros(M,N);
for i = 1:M
    for j = 1:N
        d = ((i-m_mid)^2+(j-n_mid)^2);
        h(i,j) = exp(-(d)/(2*(d0^2)));      
    end
end

img_lpf = h.*img_f;

img_lpf=ifftshift(img_lpf);    
img_lpf=uint8(real(ifft2(img_lpf)));  

subplot(1,2,1);imshow(image);title('original');
subplot(1,2,2);imshow(img_lpf);title('d=50');

