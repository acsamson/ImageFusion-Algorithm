close all;clear all;clc;
% alpha
cnn1= imread('sourceimages/alpha_cnn.tif');  
cnn2= imread('sourceimages/alpha.bmp');  
dct1= imread('sourceimages/alpha_dct.tif');  
dct2= imread('sourceimages/alpha.bmp'); 
gff1= imread('sourceimages/alpha_gff.tif');  
gff2= imread('sourceimages/alpha.bmp'); 
wave1= imread('sourceimages/alpha_wave.tif');  
wave2= imread('sourceimages/alpha.bmp');
if size(cnn1,3) == 3
    cnn1 = rgb2gray(cnn1);
end
if size(cnn2,3) == 3
    cnn2 = rgb2gray(cnn2);
end
if size(dct1,3) == 3
    dct1 = rgb2gray(dct1);
end
if size(dct2,3) == 3
    dct2 = rgb2gray(dct2);
end
if size(gff1,3) == 3
    gff1 = rgb2gray(gff1);
end
if size(gff2,3) == 3
    gff2 = rgb2gray(gff2);
end
if size(wave1,3) == 3
    gff1 = rgb2gray(wave1);
end
if size(wave2,3) == 3
    gff2 = rgb2gray(wave2);
end
disp("-------alpha-------")
ssim(cnn1,cnn2)
ssim(dct1,dct2)
ssim(gff1,gff2)
ssim(wave1,wave2)
% lena
cnn1= imread('sourceimages/lena_cnn.tif');  
cnn2= imread('sourceimages/lena.bmp');  
dct1= imread('sourceimages/lena_dct.tif');  
dct2= imread('sourceimages/lena.bmp'); 
gff1= imread('sourceimages/lena_gff.tif');  
gff2= imread('sourceimages/lena.bmp'); 
wave1= imread('sourceimages/lena_wave.tif');  
wave2= imread('sourceimages/lena.bmp');
if size(cnn1,3) == 3
    cnn1 = rgb2gray(cnn1);
end
if size(cnn2,3) == 3
    cnn2 = rgb2gray(cnn2);
end
if size(dct1,3) == 3
    dct1 = rgb2gray(dct1);
end
if size(dct2,3) == 3
    dct2 = rgb2gray(dct2);
end
if size(gff1,3) == 3
    gff1 = rgb2gray(gff1);
end
if size(gff2,3) == 3
    gff2 = rgb2gray(gff2);
end
if size(wave1,3) == 3
    gff1 = rgb2gray(wave1);
end
if size(wave2,3) == 3
    gff2 = rgb2gray(wave2);
end
disp("-------lena-------")
ssim(cnn1,cnn2)  
ssim(dct1,dct2)
ssim(gff1,gff2)
ssim(wave1,wave2)
% sale
cnn1= imread('sourceimages/sale_cnn.tif');  
cnn2= imread('sourceimages/sale.bmp');  
dct1= imread('sourceimages/sale_dct.tif');  
dct2= imread('sourceimages/sale.bmp'); 
gff1= imread('sourceimages/sale_gff.tif');  
gff2= imread('sourceimages/sale.bmp'); 
wave1= imread('sourceimages/sale_wave.tif');  
wave2= imread('sourceimages/sale.bmp');
if size(cnn1,3) == 3
    cnn1 = rgb2gray(cnn1);
end
if size(cnn2,3) == 3
    cnn2 = rgb2gray(cnn2);
end
if size(dct1,3) == 3
    dct1 = rgb2gray(dct1);
end
if size(dct2,3) == 3
    dct2 = rgb2gray(dct2);
end
if size(gff1,3) == 3
    gff1 = rgb2gray(gff1);
end
if size(gff2,3) == 3
    gff2 = rgb2gray(gff2);
end
if size(wave1,3) == 3
    gff1 = rgb2gray(wave1);
end
if size(wave2,3) == 3
    gff2 = rgb2gray(wave2);
end
disp("-------sale-------")
ssim(cnn1,cnn2)  
ssim(dct1,dct2)
ssim(gff1,gff2)
ssim(wave1,wave2)
% zebra
cnn1= imread('sourceimages/zebra_cnn.tif');  
cnn2= imread('sourceimages/zebra.bmp');  
dct1= imread('sourceimages/zebra_dct.tif');  
dct2= imread('sourceimages/zebra.bmp'); 
gff1= imread('sourceimages/zebra_gff.tif');  
gff2= imread('sourceimages/zebra.bmp'); 
wave1= imread('sourceimages/zebra_wave.tif');  
wave2= imread('sourceimages/zebra.bmp');
if size(cnn1,3) == 3
    cnn1 = rgb2gray(cnn1);
end
if size(cnn2,3) == 3
    cnn2 = rgb2gray(cnn2);
end
if size(dct1,3) == 3
    dct1 = rgb2gray(dct1);
end
if size(dct2,3) == 3
    dct2 = rgb2gray(dct2);
end
if size(gff1,3) == 3
    gff1 = rgb2gray(gff1);
end
if size(gff2,3) == 3
    gff2 = rgb2gray(gff2);
end
if size(wave1,3) == 3
    gff1 = rgb2gray(wave1);
end
if size(wave2,3) == 3
    gff2 = rgb2gray(wave2);
end
disp("-------zebra-------")
ssim(cnn1,cnn2)  
ssim(dct1,dct2)
ssim(gff1,gff2)
ssim(wave1,wave2)
% comic
cnn1= imread('sourceimages/comic_cnn.tif');  
cnn2= imread('sourceimages/comic.bmp');  
dct1= imread('sourceimages/comic_dct.tif');  
dct2= imread('sourceimages/comic.bmp'); 
gff1= imread('sourceimages/comic_gff.tif');  
gff2= imread('sourceimages/comic.bmp'); 
wave1= imread('sourceimages/comic_wave.tif');  
wave2= imread('sourceimages/comic.bmp');
if size(cnn1,3) == 3
    cnn1 = rgb2gray(cnn1);
end
if size(cnn2,3) == 3
    cnn2 = rgb2gray(cnn2);
end
if size(dct1,3) == 3
    dct1 = rgb2gray(dct1);
end
if size(dct2,3) == 3
    dct2 = rgb2gray(dct2);
end
if size(gff1,3) == 3
    gff1 = rgb2gray(gff1);
end
if size(gff2,3) == 3
    gff2 = rgb2gray(gff2);
end
if size(wave1,3) == 3
    gff1 = rgb2gray(wave1);
end
if size(wave2,3) == 3
    gff2 = rgb2gray(wave2);
end
disp("-------comic-------")
ssim(cnn1,cnn2)  
ssim(dct1,dct2)
ssim(gff1,gff2)
ssim(wave1,wave2)