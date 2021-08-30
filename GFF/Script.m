clc,clear
%%%% gray image fusion
% I = load_images( '.\sourceimages\grayset',1); 
% F = GFF(I);
% imshow(F);
%%%% color image fusion
I = load_images( 'Sourceimages/alpha',1); 
F = GFF(I);
figure,imshow(F);
imwrite(F,'alpha_gff.tif');
% lena
I = load_images( 'Sourceimages/lena',1); 
F = GFF(I);
figure,imshow(F);
imwrite(F,'lena_gff.tif');
% sale
I = load_images( 'Sourceimages/sale',1); 
F = GFF(I);
figure,imshow(F);
imwrite(F,'sale_gff.tif');
% zebra
I = load_images( 'Sourceimages/zebra',1); 
F = GFF(I);
figure,imshow(F);
imwrite(F,'zebra_gff.tif');
% comic
I = load_images( 'Sourceimages/comic',1); 
F = GFF(I);
figure,imshow(F);
imwrite(F,'comic_gff.tif');