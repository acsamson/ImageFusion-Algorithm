function P=maxpooling_s2(A)

[h,w]=size(A);

if mod(h,2)==1 %如果高度/2有余数,即奇数行
    A=[A;zeros(1,w)];%1行w列加入A
    h=h+1;
end
if mod(w,2)==1
    A=[A,zeros(h,1)];
    w=w+1;
end

A1=A(1:2:h-1,1:2:w-1);%从第一行开始,每两行取一行,直到最后一行
A2=A(1:2:h-1,2:2:w);
A3=A(2:2:h,1:2:w-1);
A4=A(2:2:h,2:2:w);

P1=max(A1,A2);
P2=max(A3,A4);
P=max(P1,P2);
