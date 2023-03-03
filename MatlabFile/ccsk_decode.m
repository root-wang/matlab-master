function [data_out] = ccsk_decode(data_in)
%CCSK����

% data_in1=randi([0 1],1,545);
% data_in=ccsk(data_in1);
%data_in=randi([0 1],1,109*32);

Vth=10;%Vmax���ֵ����ȡ��32��Vave���ֵ����ȡ��3
bori=[0 1 1 1 1 1 0 0 1 1 1 0 1 0 0 1 0 0 0 0 1 0 1 0 1 1 1 0 1 1 0 0];
b=[bori bori];
Vmax=zeros(1,109);
Vave=zeros(1,109);
Pmax=zeros(1,109);
data_out=zeros(1,109*5);
i=1;
for i=1:109
   data_32=data_in(1+(i-1)*32:32*i);
   [r,lag]=xcorr(2*b-1,2*data_32-1);
   [Vmax(i),I]=max(abs(r(64:end)));%�Ի����ֵ�������ƵĲ���
   Vave(i)=sum(abs(r(I+64+1:I+64+8)))/8;
   Pmax(i)=lag(I+63);
   %���Vmax/VaveС�ڻ����Vth���������ֵ������Pmax��0
   if Vmax(i)/Vave(i)<=Vth
      Pmax(i)=0; 
   end
   data_out(1+(i-1)*5:5*i)=de2bi(Pmax(i),5,'left-msb');
end
end
