function imDst = boxfilter(imSrc, r)
%参考博客https://blog.csdn.net/lizhengwei92/article/details/50297391
%% 包滤波器主要为了加速窗口计算用,简单平滑去噪声
[hei, wid] = size(imSrc);
imDst = zeros(size(imSrc));%先设一个零矩阵
imCum = cumsum(imSrc, 1);%列向量主次向上求和，输出同大小的矩阵

%% 计算行(Y轴)
%对矩阵顶部边缘，求每个元素中心半径为 r 的不完整窗口内的和
imDst(1:r+1, :) = imCum(1+r:2*r+1, :);%从第1行 到 第 r+1 行，该元素中心半径为 r 的窗口，包含矩阵中的行元素的和 即是 该元素 沿列向上求和，，也就是imCum对应的值。
%对矩阵中间部分，每个元素的半径为 r 的窗口都能完整的包含在矩阵中，则窗口内的和为 2*r+1 个元素的和。
imDst(r+2:hei-r, :) = imCum(2*r+2:hei, :) - imCum(1:hei-2*r-1, :);%相隔 n 行的 imCum(i+n,:) 与 imCum(i,:) 的差即是中间 n 个行元素的和。
%对矩阵底部边缘部分，仿照对顶端不完整窗口求和方法，稍加改动即可。
imDst(hei-r+1:hei, :) = repmat(imCum(hei, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :);%imCum后面的元素减去前面的元素，得到相隔的元素的和。

%% 计算列(X轴)
imCum = cumsum(imDst, 2);
imDst(:, 1:r+1) = imCum(:, 1+r:2*r+1);
imDst(:, r+2:wid-r) = imCum(:, 2*r+2:wid) - imCum(:, 1:wid-2*r-1);
imDst(:, wid-r+1:wid) = repmat(imCum(:, wid), [1, r]) - imCum(:, wid-2*r:wid-r-1);
end

