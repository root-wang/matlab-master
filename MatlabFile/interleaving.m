function [data_out] = interleaving(data_in)
%��֯
%110������д��22��5�У���֯���Ϊ5
%data_in=randi([0 1],1,545);

%bit to symbol
data_in=reshape(data_in,5,[]);
data_dec=pow2(size(data_in,1)-1:-1:0)*data_in;
%��֯
data_dec=[data_dec 0];
data_x=reshape(data_dec,5,[]).';
data_out_dec=reshape(data_x,1,[]);
%symbol to bit
data_out=de2bi(data_out_dec,'left-msb');
data_out=reshape(data_out.',1,[]);

data_out=data_out(1:length(data_out)-5);
end