function data_out=trans_encrypt(data_in)
%传输加扰
%data_in=randi([0 1],1,3488);
%生成Gold序列
f1=de2bi(4179,'left-msb');%D12+D6+D4+D1+1
f1=fliplr(f1);
f1=f1(2:end);
f2=de2bi(4201,'left-msb');%D12+D6+D5+D3+1
f2=fliplr(f2);
f2=f2(2:end);
m1=mseq(f1);
m2=mseq(f2);
Gold=xor(m1,m2);

Gold=Gold(1:3488);
data_out=xor(data_in,Gold);
data_out=double(data_out);
end