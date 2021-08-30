clc;close all; 

% alpha 
X1=imread('sourseImages/alpha_A.tif');
X1=double(X1)/256; 
X2=imread('sourseImages/alpha_B.tif');
X2=double(X2)/256; 
Temp = wfusimg(X1,X2,'db2',5,'mean','max');  %采用db2波，5层分解进行融合，其中低频取平均，高频取大  
colormap(map);
imwrite(Temp,'results/alpha_wave.tif');                                 
subplot(221),image(X1);  %显示图像               
subplot(222),image(X2);  
subplot(223),image(Temp);  
% lena 
X1=imread('sourseImages/lena_A.tif');
X1=double(X1)/256; 
X2=imread('sourseImages/lena_B.tif');
X2=double(X2)/256; 
Temp = wfusimg(X1,X2,'db2',5,'mean','max');  %采用db2波，5层分解进行融合，其中低频取平均，高频取大  
colormap(map);
imwrite(Temp,'results/lena_wave.tif');                                 
subplot(221),image(X1);  %显示图像               
subplot(222),image(X2);  
subplot(223),image(Temp); 
% sale 
X1=imread('sourseImages/sale_A.tif');
X1=double(X1)/256; 
X2=imread('sourseImages/sale_B.tif');
X2=double(X2)/256; 
Temp = wfusimg(X1,X2,'db2',5,'mean','max');  %采用db2波，5层分解进行融合，其中低频取平均，高频取大  
colormap(map);
imwrite(Temp,'results/sale_wave.tif');                                 
subplot(221),image(X1);  %显示图像               
subplot(222),image(X2);  
subplot(223),image(Temp); 
% zebra 
X1=imread('sourseImages/zebra_A.tif');
X1=double(X1)/256; 
X2=imread('sourseImages/zebra_B.tif');
X2=double(X2)/256; 
Temp = wfusimg(X1,X2,'db2',5,'mean','max');  %采用db2波，5层分解进行融合，其中低频取平均，高频取大  
colormap(map);
imwrite(Temp,'results/zebra.tif');                                 
subplot(221),image(X1);  %显示图像               
subplot(222),image(X2);  
subplot(223),image(Temp); 
% comic 
X1=imread('sourseImages/comic_A.tif');
X1=double(X1)/256; 
X2=imread('sourseImages/comic_B.tif');
X2=double(X2)/256; 
Temp = wfusimg(X1,X2,'db2',5,'mean','max');  %采用db2波，5层分解进行融合，其中低频取平均，高频取大  
colormap(map);
imwrite(Temp,'results/comic_wave.tif');                                 
subplot(221),image(X1);  %显示图像               
subplot(222),image(X2);  
subplot(223),image(Temp); 
