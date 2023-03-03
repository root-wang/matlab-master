function [data_out] = ccsk(data_in)
%CCSK,bori=[0 1 1 1 1 1 0 0 1 1 1 0 1 0 0 1 0 0 0 0 1 0 1 0 1 1 1 0 1 1 0
%0];
%data_in=randi([0 1],1,545);

data_out=zeros(1,109*32);

%bit to symbol
data_in=reshape(data_in,5,[]);
%data_dec=pow2(size(data_in,1)-1:-1:0)*data_in;
data_dec=bi2de(data_in.','left-msb').';

%CCSk±àÂë
bori=[0 1 1 1 1 1 0 0 1 1 1 0 1 0 0 1 0 0 0 0 1 0 1 0 1 1 1 0 1 1 0 0];
b=[bori bori];
for i=1:109
    M=data_dec(i);
    data_out(1+(i-1)*32:32*i)=b(1+M:32+M);
end
end