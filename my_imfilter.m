function output = my_imfilter(image, filter)

intput_image = image;

[intput_row, intput_col] = size(intput_image(:,:,1));

[filter_row, filter_col] = size(filter);

pad_input_image = padarray(intput_image, [(filter_row - 1)/2, (filter_col - 1)/2]);

output = [];

for layer = 1:size(intput_image, 3) 
   
    columns = im2col(pad_input_image(:,:,layer), [filter_row, filter_col]);
  
    filter2 = transpose(filter(:));
 
    filterd_columns = filter2 * columns;

    output(:,:,layer) = col2im(filterd_columns, [1, 1], [intput_row, intput_col]);
end
