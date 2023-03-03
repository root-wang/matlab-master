function [crc_false,data_msg] = crc_decode(data_in,header_word)
%CRC解码，输出错误标志位和210bit信息
data_msg=zeros(1,210);
data_crc1=zeros(1,12);
for i=1:3
   data_msg(1+(i-1)*70:70*i)=data_in(1+(i-1)*75:70+(i-1)*75);
   data_crc1(1+(i-1)*4:4*i)=data_in(72+(i-1)*75:75*i);
end
data_msg1=[data_msg,header_word(4:18)];
[data_crc2,~]=crc(data_msg1);
if data_crc2==data_crc1
   crc_false=0; 
else
   crc_false=1;
end
end