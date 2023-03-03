function [ data_fh_d] = fh( fh_index,bandsignal_d)
%跳频调制

%生成64进制m序列
g=[1 0 0 0 0 1];%g(x)=x^6+x+1
n=length(g);
N=2^n-1;
register=[zeros(1,n-1),1];
newregister=zeros(1,n);
m=zeros(1,N);
for i=1:N
    m(i)=bi2de(fliplr(register),'left-msb');
    newregister(1)=mod(sum(g.*register),2);
    for j=2:n
        newregister(j)=register(j-1);
    end
    register=newregister;
    %m(i)=bi2de(register,'left-msb');
end
%生成宽间隔跳频序列F1
m_51=mod(m,51)+1;
F=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 28 29 30 31 32 48 49 50 51 52 53 54....
    55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71....
    72 73 74 75 76 77 78 79];
F1=zeros(1,N);
index=zeros(1,N);
F1(1)=F(m_51(1));
for i=2:N
    index(i)=m_51(i);
    F1(i)=F(index(i));
    if abs(F1(i)-F1(i-1))<10
        index(i)=index(i-1)+10;
        F1(i)=F(index(i));
    end
end

frequency=(969+3*F1)*1e6;
fs=5e8;
Tbnumber=100;
bandsignal_num=32;
bandsignal_t=1/fs:1/fs:Tbnumber*bandsignal_num*1/fs;
data_fh_d=bandsignal_d.*cos(2*pi*frequency(fh_index)*bandsignal_t);
end