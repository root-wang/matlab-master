function [data_out] = rs_decode(data_in)
%rs����
%data_in=randi([0 1],1,260);
%5bit�����Ƶ�ʮ����
data_in=reshape(data_in,5,[]).';
data_dec=bi2de(data_in,'left-msb').';
%rs(31,15)����
data_g=gf(data_dec,5,'D5+D2+1');
data_g2=data_g(17:109);
msg_2=zeros(1,15*3);
for i=1:3
   msg_2(1+(i-1)*15:15*i)=rsdec(data_g2(1+(i-1)*31:31*i),31,15).x;
end
%rs(16,7)����
hDec = comm.RSDecoder(23,7);
hDec.PuncturePatternSource='Property';
hDec.PuncturePattern=[ones(9,1);zeros(7,1)];
msg_1=hDec(data_dec(1:16).').';

msg_dec=[msg_1,msg_2];
%ʮ���Ƶ�������
data_out=de2bi(msg_dec,'left-msb');
data_out=reshape(data_out.',1,[]);%reshape���Ȱ������
end