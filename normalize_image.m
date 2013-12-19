% Normalize input image. Remove unnecessary rows of image. 60 px height.
function B = normalize_image(A)
[m,~] = size(A);
no_pixel_row = 1:m;
for jj = 1:m;
    if ~any(A(jj,:))
        no_pixel_row(jj) = 0;
    end
end
no_pixel_row = find(no_pixel_row);
B = A(no_pixel_row,:);
B = imresize(B,[60 NaN],'Colormap','original');
end