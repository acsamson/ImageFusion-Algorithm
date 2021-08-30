function F = CNN_Fusion(A,B,model_name)
%% ��ʼͼ��Ԥ��
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
%% ����cnnģ��
disp('load the CNN model......')
load(model_name);
[conv1_patchsize2,conv1_filters] = size(weights_b1_1);  %9*64
conv1_patchsize = sqrt(conv1_patchsize2);

[conv2_channels,conv2_patchsize2,conv2_filters] = size(weights_b1_2);  %64*9*128(�������64,��С3��3,������128)
conv2_patchsize = sqrt(conv2_patchsize2);
[conv3_channels,conv3_patchsize2,conv3_filters] = size(weights_b1_3);  %128*9*256
conv3_patchsize = sqrt(conv3_patchsize2);
[conv4_channels,conv4_patchsize2,conv4_filters] = size(weights_feature); %512*64*256
conv4_patchsize = sqrt(conv4_patchsize2);
[conv5_channels,conv5_patchsize2,conv5_filters] = size(weights_output);  %256*1*2
conv5_patchsize = sqrt(conv5_patchsize2);
%% ģ��cnn����
disp('ģ��cnn������......')
%%%%%%%%%%%%%%%%%%%% conv1 %%%%%%%%%%%%%%%%%%%%
disp('---conv1---')
weights_conv1 = reshape(weights_b1_1, conv1_patchsize, conv1_patchsize, conv1_filters);
conv1_data1 = zeros(hei, wid, conv1_filters,'single');
conv1_data2 = zeros(hei, wid, conv1_filters,'single');
for i = 1 : conv1_filters
    conv1_data1(:,:,i) = conv2(img1_gray, rot90(weights_conv1(:,:,i),2), 'same');%convn�����������Ͷ�����������ת����������תһ����Ϊ�˸�ԭ�������
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
conv2_data1_pooling=zeros(ceil(hei/2), ceil(wid/2), conv2_filters,'single');%matpooling����Ϊ2,�����Ҫ����2����
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
conv3_data=cat(3,conv3_data1,conv3_data2);  %ģ��concat��,����ͼ��ƴ��
clear conv3_data1 conv3_data2
%%%%%%%%%%%%%%%%%%%% conv4 %%%%%%%%%%%%%%%%%%%%
disp('---conv4---')
%ģ��8��8�˲�,�ʷֱ��ʴ�СΪ/2-8+1,ȡ�������������.
conv4_data=zeros(ceil(hei/2)-conv4_patchsize+1,ceil(wid/2)-conv4_patchsize+1,conv4_filters,'single');
for i = 1 : conv4_filters
    for j = 1 : conv4_channels
        conv4_subfilter = rot90((reshape(weights_feature(j,:,i), conv4_patchsize, conv4_patchsize)),2);%�˲���
        conv4_data(:,:,i) = conv4_data(:,:,i) + conv2(conv3_data(:,:,j), conv4_subfilter, 'valid');%validָ�˲���ȫ��������
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
output_data(:,:,1)=exp(conv5_data(:,:,1))./(exp(conv5_data(:,:,1))+exp(conv5_data(:,:,2)));%�������
output_data(:,:,2)=1-output_data(:,:,1);%����softmax������ֻҪͨ��:1-ָ�������Ľ��������ģ��ʵ��
outMap=output_data(:,:,2);%��ֵͼ�Ĵ�С��ԭʼͼ/2-8+1����
figure;imshow(uint8(outMap*255));title('out map');
imwrite(uint8(outMap*255),'results/outmap.tif');
clear conv5_data
%% focus map generation
disp('��ʼ����ͼ���ں�......')
sumMap=zeros(hei,wid);
cntMap=zeros(hei,wid);
patch_size=16; %������ĵ���ѵ����С  
stride=2; %��Ϊ������һ�γػ�,�ػ���С��һ��,���Բ���Ϊ2
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
        %ÿ��16��16�Ŀ�,���и�ֵ���ҵ��Ӽ���
        sumMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)=sumMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)+outMap(j,i);%�Ƚ��е���,֮���ٳ�ȥȡƽ��
        cntMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)=cntMap(jj:jj+temp_size_y-1,ii:ii+temp_size_x-1)+1;%Ϊ�˼���ÿ������˶��ٴ�,Ϊ����ƽ������
    end
end
focusMap=sumMap./cntMap;
figure;imshow(uint8(focusMap*255));title('Focus map');
imwrite(uint8(focusMap*255),'results/Focus_map.tif');
%% ��ʼ���ָ�
disp('��ʼ���ָ�......')
decisionMap=zeros(hei,wid);
decisionMap(focusMap>0.5)=1;
decisionMap(focusMap<=0.5)=0;
figure;imshow(uint8(decisionMap*255));title('Binary segmented map');
imwrite(uint8(decisionMap*255),'results/Binary_segmented_map.tif');
%% һ������֤
disp('һ������֤......')
%С����ȥ��
ratio=0.01;%�����
area=ceil(ratio*hei*wid);
tempMap1=bwareaopen(decisionMap,area);%bwareaopenΪС����ȥ������
tempMap2=1-tempMap1;
tempMap3=bwareaopen(tempMap2,area);%��Ҫ��תһ��,��Ϊ�����ֻ�ǵ���ֵ��Χ
decisionMap=1-tempMap3;
figure;imshow(uint8(decisionMap*255));title('Initial decision map');
imwrite(uint8(decisionMap*255),'results/Initial_decision_map.tif');
%�����˲�ȥ����,��ƽ��
imgf_gray=img1_gray.*decisionMap+img2_gray.*(1-decisionMap);%�Ⱥ�֮ǰ�ĻҶ�ͼ���м򵥼�Ȩƽ������ȥ�봦��
decisionMap = guidedfilter(imgf_gray,decisionMap,8,0.1);%���ڰ뾶Ϊ8,���򻯲���Ϊ0.1�����˲���������
figure;imshow(uint8(decisionMap*255));title('Final decision map');
imwrite(uint8(decisionMap*255),'results/Final_decision_map.tif');
if size(img1,3)>1 %������ǻҶ�ͼ
    decisionMap=repmat(decisionMap,[1 1 3]);%��1��1��3��A��ƽ��
end
%% fusion
disp('ͼ���ں�......')
imgf=img1.*decisionMap+img2.*(1-decisionMap);
F=uint8(imgf*255);
end
