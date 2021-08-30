function F = CNN_Fusion(A,B,model_name)
%% 初始图像预备
img1 = double(A)/255;
img2 = double(B)/255;
if size(img1,3)>1
    img1_gray=rgb2gray(img1);
    img2_gray=rgb2gray(img2);
else
    img1_gray=img1;
    img2_gray=img2;
end
[hei, wid] = size(img1_gray);
%% 导入cnn模型
disp('load the CNN model......')
load(model_name);
[conv1_patchsize2,conv1_filters] = size(weights_b1_1);  %9*64
conv1_patchsize = sqrt(conv1_patchsize2);

[conv2_channels,conv2_patchsize2,conv2_filters] = size(weights_b1_2);  %64*9*128(输入深度64,大小3×3,输出深度128)
conv2_patchsize = sqrt(conv2_patchsize2);
[conv3_channels,conv3_patchsize2,conv3_filters] = size(weights_b1_3);  %128*9*256
conv3_patchsize = sqrt(conv3_patchsize2);
[conv4_channels,conv4_patchsize2,conv4_filters] = size(weights_feature); %512*64*256
conv4_patchsize = sqrt(conv4_patchsize2);
[conv5_channels,conv5_patchsize2,conv5_filters] = size(weights_output);  %256*1*2
conv5_patchsize = sqrt(conv5_patchsize2);
%% 模拟cnn网络
disp('模拟cnn网络中......')
%%%%%%%%%%%%%%%%%%%% conv1 %%%%%%%%%%%%%%%%%%%%
disp('---conv1---')
weights_conv1 = reshape(weights_b1_1, conv1_patchsize, conv1_patchsize, conv1_filters);
conv1_data1 = zeros(hei, wid, conv1_filters,'single');
conv1_data2 = zeros(hei, wid, conv1_filters,'single');
for i = 1 : conv1_filters
    conv1_data1(:,:,i) = conv2(img1_gray, rot90(weights_conv1(:,:,i),2), 'same');%convn这个函数本身就对算子做了旋转，这里再旋转一次是为了复原，做相关
    conv1_data1(:,:,i) = max(conv1_data1(:,:,i) + biases_b1_1(i), 0);
    conv1_data2(:,:,i) = conv2(img2_gray, rot90(weights_conv1(:,:,i),2), 'same');
    conv1_data2(:,:,i) = max(conv1_data2(:,:,i) + biases_b1_1(i), 0);
end
%%%%%%%%%%%%%%%%%%%%%%% conv2 %%%%%%%%%%%%%%%%%%%%
disp('---conv2---')
conv2_data1 = zeros(hei, wid, conv2_filters,'single');
conv2_data2 = zeros(hei, wid, conv2_filters,'single');
for i = 1 : conv2_filters
    for j = 1 : conv2_channels
        conv2_subfilter = rot90(reshape(weights_b1_2(j,:,i), conv2_patchsize, conv2_patchsize),2);
        conv2_data1(:,:,i) = conv2_data1(:,:,i) + conv2(conv1_data1(:,:,j), conv2_subfilter, 'same');
        conv2_data2(:,:,i) = conv2_data2(:,:,i) + conv2(conv1_data2(:,:,j), conv2_subfilter, 'same');
    end
    conv2_data1(:,:,i) = max(conv2_data1(:,:,i) + biases_b1_2(i), 0);
    conv2_data2(:,:,i) = max(conv2_data2(:,:,i) + biases_b1_2(i), 0);
end
clear conv1_data1 conv1_data2 
%%%%%%%%%%%%%%%%%%%% max-pooling1 %%%%%%%%%%%%%%%%%%%%
disp('---maxpool1---')
conv2_data1_pooling=zeros(ceil(hei/2), ceil(wid/2), conv2_filters,'single');%matpooling步长为2,因此需要除以2处理
conv2_data2_pooling=zeros(ceil(hei/2), ceil(wid/2), conv2_filters,'single');
for i = 1 : conv2_filters    
    conv2_data1_pooling(:,:,i) = maxpooling_s2(conv2_data1(:,:,i));
    conv2_data2_pooling(:,:,i) = maxpooling_s2(conv2_data2(:,:,i));
end
clear conv2_data1 conv2_data2
%%%%%%%%%%%%%%%%%%%% conv3 %%%%%%%%%%%%%%%%%%%%
disp('---conv3---')
conv3_data1 = zeros(ceil(hei/2), ceil(wid/2), conv3_filters,'single');
conv3_data2 = zeros(ceil(hei/2), ceil(wid/2), conv3_filters,'single');
for i = 1 : conv3_filters
    for j = 1 : conv3_channels
        conv3_subfilter = rot90(reshape(weights_b1_3(j,:,i), conv3_patchsize, conv3_patchsize),2);
        conv3_data1(:,:,i) = conv3_data1(:,:,i) + conv2(conv2_data1_pooling(:,:,j), conv3_subfilter, 'same');
        conv3_data2(:,:,i) = conv3_data2(:,:,i) + conv2(conv2_data2_pooling(:,:,j), conv3_subfilter, 'same');
    end
    conv3_data1(:,:,i) = max(conv3_data1(:,:,i) + biases_b1_3(i), 0);
    conv3_data2(:,:,i) = max(conv3_data2(:,:,i) + biases_b1_3(i), 0);
end
clear conv2_data1_pooling conv2_data2_pooling
conv3_data=cat(3,conv3_data1,conv3_data2);  %模拟concat层,进行图像拼接
clear conv3_data1 conv3_data2
%%%%%%%%%%%%%%%%%%%% conv4 %%%%%%%%%%%%%%%%%%%%
disp('---conv4---')
%模拟8×8滤波,故分辨率大小为/2-8+1,取的是左上区域块.
conv4_data=zeros(ceil(hei/2)-conv4_patchsize+1,ceil(wid/2)-conv4_patchsize+1,conv4_filters,'single');
for i = 1 : conv4_filters
    for j = 1 : conv4_channels
        conv4_subfilter = rot90((reshape(weights_feature(j,:,i), conv4_patchsize, conv4_patchsize)),2);%滤波器
        conv4_data(:,:,i) = conv4_data(:,:,i) + conv2(conv3_data(:,:,j), conv4_subfilter, 'valid');%valid指滤波器全含矩阵内
    end
end
clear conv3_data
%%%%%%%%%%%%%%%%%%%% conv5  %%%%%%%%%%%%%%%%%%%%
disp('---conv5---')
conv5_data=zeros(ceil(hei/2)-conv4_patchsize+1,ceil(wid/2)-conv4_patchsize+1,conv5_filters,'single');
for i = 1 : conv5_filters
    for j = 1 : conv5_channels    
        conv5_subfilter = rot90(reshape(weights_output(j,:,i), conv5_patchsize, conv5_patchsize),2);
        conv5_data(:,:,i) = conv5_data(:,:,i) + conv2(conv4_data(:,:,j), conv5_subfilter);
    end
end
clear conv4_data
%%%%%%%%%%%%%%%%%%%% softmax %%%%%%%%%%%%%%%%%%%%
disp('---softmax---')
output_data=zeros(ceil(hei/2)-conv4_patchsize+1,ceil(wid/2)-conv4_patchsize+1,conv5_filters,'single');
output_data(:,:,1)=exp(conv5_data(:,:,1))./(exp(conv5_data(:,:,1))+exp(conv5_data(:,:,2)));%点除运算
output_data(:,:,2)=1-output_data(:,:,1);%根据softmax计算结果只要通过:1-指数运算后的结果即可以模拟实现
outMap=output_data(:,:,2);%分值图的大小是原始图/2-8+1得来
figure;imshow(uint8(outMap*255));title('out map');
imwrite(uint8(outMap*255),'results/outmap.tif');
clear conv5_data
%% focus map generation
disp('开始进行图像融合......')
sumMap=zeros(hei,wid);
cntMap=zeros(hei,wid);
patch_size=16; %神经网络的导入训练大小  
stride=2; %因为进行了一次池化,池化缩小了一半,所以步长为2
y_bound=hei-patch_size+1;
x_bound=wid-patch_size+1;
[h,w]=size(outMap);
for j=1:h
    jj=(j-1)*stride+1;
    if jj<=y_bound
        temp_size_y=patch_size;
    else
        temp_size_y=hei-jj+1;
    end
    for i=1:w
        ii=(i-1)*stride+1;
        if ii<=x_bound
            temp_size_x=patch_size;
        else
            temp_size_x=wid-ii+1;
        end
        %每个16×16的块,进行赋值并且叠加计算
        sumMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)=sumMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)+outMap(j,i);%先进行叠加,之后再除去取平均
        cntMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)=cntMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)+1;%为了计算每块叠加了多少次,为了求平均所用
    end
end
focusMap=sumMap./cntMap;
figure;imshow(uint8(focusMap*255));title('Focus map');
imwrite(uint8(focusMap*255),'results/Focus_map.tif');
%% 初始化分割
disp('初始化分割......')
decisionMap=zeros(hei,wid);
decisionMap(focusMap>0.5)=1;
decisionMap(focusMap<=0.5)=0;
figure;imshow(uint8(decisionMap*255));title('Binary segmented map');
imwrite(uint8(decisionMap*255),'results/Binary_segmented_map.tif');
%% 一致性验证
disp('一致性验证......')
%小区域去除
ratio=0.01;%面积率
area=ceil(ratio*hei*wid);
tempMap1=bwareaopen(decisionMap,area);%bwareaopen为小区域去除函数
tempMap2=1-tempMap1;
tempMap3=bwareaopen(tempMap2,area);%需要翻转一次,因为处理的只是单数值范围
decisionMap=1-tempMap3;
figure;imshow(uint8(decisionMap*255));title('Initial decision map');
imwrite(uint8(decisionMap*255),'results/Initial_decision_map.tif');
%导向滤波去噪声,简单平滑
imgf_gray=img1_gray.*decisionMap+img2_gray.*(1-decisionMap);%先和之前的灰度图进行简单加权平均进行去噪处理
decisionMap = guidedfilter(imgf_gray,decisionMap,8,0.1);%窗口半径为8,正则化参数为0.1导向滤波计算所用
figure;imshow(uint8(decisionMap*255));title('Final decision map');
imwrite(uint8(decisionMap*255),'results/Final_decision_map.tif');
if size(img1,3)>1 %如果不是灰度图
    decisionMap=repmat(decisionMap,[1 1 3]);%由1×1×3个A块平铺
end
%% fusion
disp('图像融合......')
imgf=img1.*decisionMap+img2.*(1-decisionMap);
F=uint8(imgf*255);
end
