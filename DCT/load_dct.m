clc,clear
% alpha
A = imread( 'Sourceimages/alpha_A.tif'); 
B = imread( 'Sourceimages/alpha_B.tif'); 
F = dctVarFusion(A,B);
figure,imshow(F);
imwrite(F,'alpha_dct.tif');
% lena
A = imread( 'Sourceimages/lena_A.tif'); 
B = imread( 'Sourceimages/lena_B.tif'); 
F = dctVarFusion(A,B);
figure,imshow(F);
imwrite(F,'lena_dct.tif');
% sale
A = imread( 'Sourceimages/sale_A.tif'); 
B = imread( 'Sourceimages/sale_B.tif'); 
F = dctVarFusion(A,B);
figure,imshow(F);
imwrite(F,'sale_dct.tif');
% zebra
A = imread( 'Sourceimages/zebra_A.tif'); 
B = imread( 'Sourceimages/zebra_B.tif'); 
F = dctVarFusion(A,B);
figure,imshow(F);
imwrite(F,'zebra_dct.tif');
% comic
A = imread( 'Sourceimages/comic_A.tif'); 
B = imread( 'Sourceimages/comic_B.tif'); 
F = dctVarFusion(A,B);
figure,imshow(F);
imwrite(F,'comic_dct.tif');