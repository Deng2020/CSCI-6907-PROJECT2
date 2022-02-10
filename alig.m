function [image1,image2]=alignment( )

img1 = im2single(imread('../data/cat.bmp'));
img2 = im2single(imread('../data/dog.bmp'));
% img1 = rgb2gray(img1);  % convert to grayscale
% img2 = rgb2gray(img2);

% Align the two images, e.g. by the eyes. (translation, scale, rotation)
[h1, w1, c1] = size(img1);  % get image size
[h2, w2, c2] = size(img2);

disp('Select two points from each image define rotation, scale, trans.')
figure(1), hold off, imagesc(img1), axis image, colormap default;
[x1, y1] = ginput(2);
cx1 = mean(x1); cy1 = mean(y1);
figure(1), hold off, imagesc(img2), axis image;  % displays image
[x2, y2] = ginput(2);
cx2 = mean(x2); cy2 = mean(y2);

tx = round((w1/2-cx1)*2);  % translate first so that center of ref points
if tx > 0, img1 = padarray(img1, [0 tx], 'pre');     % is center of image
else,      img1 = padarray(img1, [0 -tx], 'post'); end
ty = round((h1/2-cy1)*2);
if ty > 0, img1 = padarray(img1, [ty 0], 'pre');
else,      img1 = padarray(img1, [-ty 0], 'post'); end
tx = round((w2/2-cx2)*2);
if tx > 0,  img2 = padarray(img2, [0 tx], 'pre');
else,       img2 = padarray(img2, [0 -tx], 'post'); end
ty = round((h2/2-cy2)*2);
if ty > 0,  img2 = padarray(img2, [ty 0], 'pre');
else,       img2 = padarray(img2, [-ty 0], 'post'); end

len1 = sqrt((y1(2)-y1(1)).^2+(x1(2)-x1(1)).^2);  % downscale larger image
len2 = sqrt((y2(2)-y2(1)).^2+(x2(2)-x2(1)).^2);  % so that lengths between
dscale = len2 ./ len1;                           % ref point are the same
if dscale < 1, img1 = imresize(img1, dscale, 'bilinear');
else,          img2 = imresize(img2, 1./dscale, 'bilinear'); end

theta1 = atan2(-(y1(2)-y1(1)), x1(2)-x1(1)); 
theta2 = atan2(-(y2(2)-y2(1)), x2(2)-x2(1));
dtheta = theta2 - theta1;                              % imrotate
img1 = imrotate(img1, dtheta*180/pi, 'bilinear');      % uses degree units

[h1, w1, c1] = size(img1);
[h2, w2, c2] = size(img2);
minw = min(w1,w2);
brd = (max(w1,w2)-minw)/2;
if minw == w1
    img2 = img2(:, ceil(brd)+1:end-floor(brd), :);
    tx = tx - ceil(brd);
else
    img1 = img1(:, ceil(brd)+1:end-floor(brd), :);
    tx = tx + ceil(brd);
end
minh = min(h1,h2);
brd = (max(h1,h2)-minh)/2;
if minh == h1
    img2 = img2(ceil(brd)+1:end-floor(brd), :, :);
    ty = ty - ceil(brd);
else
    img1 = img1(ceil(brd)+1:end-floor(brd), :, :);
    ty = ty + ceil(brd);    
end
image1=img1;
image2=img2;
end