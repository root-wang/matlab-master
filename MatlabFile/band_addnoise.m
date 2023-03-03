function [data_out] = band_addnoise(data_in)
%基带加解扰
data_out=zeros(1,225);
%生成本地m序列，m的生成多项式g(x)=x^8+x^6+x^4+x^3+x^2+x+1
f=[1 1 1 1 0 1 0 1];
n=length(f);
N=2^n-1;
register=[zeros(1,n-1),1];
newregister=zeros(1,n);
for i=1:N
    newregister(1)=mod(sum(f.*register),2);
    for j=2:n
        newregister(j)=register(j-1);
    end
    register=newregister;
    mg(i)=register(n);
end
%基带数据加扰
m=mg(1:255);
for i=1:225
    if data_in(i)==m(i)
       data_out(i)=0;
    else
       data_out(i)=1;  
    end
end
end
