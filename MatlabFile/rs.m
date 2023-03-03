function [data_out] = rs(data_in)
%RS编码,默认生成多项式g(x)=x^5+x^2+1
data_in=reshape(data_in,5,[]);
data_dec=pow2(size(data_in,1)-1:-1:0)*data_in;%每5Bit一个符号
msg=gf(data_dec,5,'D5+D2+1');
%msg_1=msg(1:7);
msg_2=msg(8:52);
msg_2_rs=zeros(1,31*3);
%genpoly=rsgenpoly(31,7,'D5+D2+1');
%msg_1_rs=rsenc(msg_1,31,7,genpoly);
for i=1:3
    msg_2_rs(1+(i-1)*31:31*i)=rsenc(msg_2(1+(i-1)*15:15*i),31,15).x;
end
hEnc = comm.RSEncoder(23,7);
hEnc.PuncturePatternSource='Property';
hEnc.PuncturePattern=[ones(9,1);zeros(7,1)];
msg_1_rs=hEnc(data_dec(1:7).').';
%十进制转化为二进制
data_out_dec=[msg_1_rs,msg_2_rs];
data_out=de2bi(data_out_dec,'left-msb');
data_out=reshape(data_out.',1,[]);%reshape优先按列输出
end