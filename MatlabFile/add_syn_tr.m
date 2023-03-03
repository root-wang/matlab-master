function [data_out]=add_syn_tr(data_in)
%��Ӿ�ͬ������syn_seq�ʹ�ͬ������tr_seq
%data_in=randi([0 1],1,3488);

%���ɴ�ͬ������syn_seq
f=de2bi(37,'left-msb');%D5+D2+1
f=f(2:end);
m=mseq(f);
m=[m,0];
m_2=[m,m];
m_extended=zeros(1,32*16);
for i=1:16
   m_extended(1+(i-1)*32:32*i)=m_2(i:31+i); 
end
syn_seq=2*m_extended-1;
%���ɾ�ͬ������tr_seq
N=32*4;
M=ceil(log2(N));
wn=0;
for i=1:M
   w2n=[wn,wn;wn,~wn];
   wn=w2n;
end
walsh=wn;
tr_seq=2*walsh(2,:)-1;%ȡ��2�У�ת��Ϊ1,-1

data_out=[syn_seq,tr_seq,2*data_in-1];
end