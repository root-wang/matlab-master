function [rem,data_out] = crc(data_in)
%link 16中的CRC部分

data_out=zeros(1,225);
%CRC编码
g=repelem([1 0 1],[1 11 1]);%g(x)=x^12+1
x=[data_in,zeros(1,12)];%m(x)*x^(N-k)
x_g=gf(x,1);%m(x)*x^(N-k)
gen_g=gf(g,1);%g(x)=x^12+1
[~,rem_g]=deconv(x_g,gen_g);%r(x)=m(x)*x^(N-k)/g(x)
rem=rem_g.x;
rem=rem(226:237);

data_x=data_in(1:210);
for i=1:3
   data_out(1+(i-1)*75:75*i)= [data_x(1+(i-1)*70:70*i)...
       ,0,rem(1+(i-1)*4:4*i)];
end
end
