close all;
clear all;
clc;
A  = imread('sourceimages/children_1.tif');
B  = imread('sourceimages/children_2.tif');
%A  = imread('sourceimages/lena_0.tif');
%B  = imread('sourceimages/lena_1.tif');
%A  = imread('sourceimages/book1.tif');
%B  = imread('sourceimages/book2.tif');
%A  = imread('sourceimages/clock1.jpg');
%B  = imread('sourceimages/clock2.jpg');
%A  = imread('sourceimages/pepsi1.tif');
%B  = imread('sourceimages/pepsi2.tif');
%%  -------------------------------------
%A  = imread('sourceimages/alpha_A.tif');
%B  = imread('sourceimages/alpha_B.tif');
%A  = imread('sourceimages/comic_A.tif');
%B  = imread('sourceimages/comic_B.tif');
%A  = imread('sourceimages/lena_A.tif');
%B  = imread('sourceimages/lena_B.tif');
%A  = imread('sourceimages/sale_A.tif');
%B  = imread('sourceimages/sale_B.tif');
%A  = imread('sourceimages/zebra_A.tif');
%B  = imread('sourceimages/zebra_B.tif');
%%  -------------------------------------
if size(A)~=size(B)
    error('two images are not the same size.');
end
figure,imshow(A);figure,imshow(B);

model_name = 'model/caffemodel.mat';

F=CNN_Fusion(A,B,model_name);

figure,imshow(F);
imwrite(F,'results/cnn.tif');