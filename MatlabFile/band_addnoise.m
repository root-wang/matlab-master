function [data_out] = band_addnoise(data_in)
%�����ӽ���
data_out=zeros(1,225);
%���ɱ���m���У�m�����ɶ���ʽg(x)=x^8+x^6+x^4+x^3+x^2+x+1
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
%�������ݼ���
m=mg(1:255);
for i=1:225
    if data_in(i)==m(i)
       data_out(i)=0;
    else
       data_out(i)=1;  
    end
end
end
