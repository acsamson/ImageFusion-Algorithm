function imDst = boxfilter(imSrc, r)
%�ο�����https://blog.csdn.net/lizhengwei92/article/details/50297391
%% ���˲�����ҪΪ�˼��ٴ��ڼ�����,��ƽ��ȥ����
[hei, wid] = size(imSrc);
imDst = zeros(size(imSrc));%����һ�������
imCum = cumsum(imSrc, 1);%����������������ͣ����ͬ��С�ľ���

%% ������(Y��)
%�Ծ��󶥲���Ե����ÿ��Ԫ�����İ뾶Ϊ r �Ĳ����������ڵĺ�
imDst(1:r+1, :) = imCum(1+r:2*r+1, :);%�ӵ�1�� �� �� r+1 �У���Ԫ�����İ뾶Ϊ r �Ĵ��ڣ����������е���Ԫ�صĺ� ���� ��Ԫ�� ����������ͣ���Ҳ����imCum��Ӧ��ֵ��
%�Ծ����м䲿�֣�ÿ��Ԫ�صİ뾶Ϊ r �Ĵ��ڶ��������İ����ھ����У��򴰿��ڵĺ�Ϊ 2*r+1 ��Ԫ�صĺ͡�
imDst(r+2:hei-r, :) = imCum(2*r+2:hei, :) - imCum(1:hei-2*r-1, :);%��� n �е� imCum(i+n,:) �� imCum(i,:) �Ĳ���м� n ����Ԫ�صĺ͡�
%�Ծ���ײ���Ե���֣����նԶ��˲�����������ͷ������ԼӸĶ����ɡ�
imDst(hei-r+1:hei, :) = repmat(imCum(hei, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :);%imCum�����Ԫ�ؼ�ȥǰ���Ԫ�أ��õ������Ԫ�صĺ͡�

%% ������(X��)
imCum = cumsum(imDst, 2);
imDst(:, 1:r+1) = imCum(:, 1+r:2*r+1);
imDst(:, r+2:wid-r) = imCum(:, 2*r+2:wid) - imCum(:, 1:wid-2*r-1);
imDst(:, wid-r+1:wid) = repmat(imCum(:, wid), [1, r]) - imCum(:, wid-2*r:wid-r-1);
end

