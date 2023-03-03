function [dedata] = msk_demodu(fs,fc,rsignal_d,Tbnumber)
%延时差分相干解调
rsignal_num=33;%rsignal_d/Tbnumber;

%时域相移pi/2
Y=fft(rsignal_d);
Y_n=length(Y);
P2=abs(Y);
fai2=angle(Y);
P1=P2(2:Y_n/2);
fai1=fai2(2:Y_n/2)+pi/2;
Y1=P1.*exp(1i*fai1);
Y1=[Y(1),Y1,Y(Y_n/2+1),fliplr(conj(Y1))];
rsignal_d_yixiang=real(ifft(Y1));

%差分相乘
de_rsignal_d=rsignal_d.*[zeros(1,Tbnumber),rsignal_d_yixiang(1:(rsignal_num-1)*Tbnumber)];%.*cos(2*pi*fc*bandsignal_t+pi/2);
de_rsignal_d=[de_rsignal_d,zeros(1,2*Tbnumber)];
% de_rsignal_t=1/fs:1/fs:(rsignal_num+2)*Tbnumber/fs;
% [de_rsignal_D,de_rsignal_f]=Bottom_make_specturm(de_rsignal_d,fs);
% Between_de_resignal_picture( de_rsignal_t,de_rsignal_d,de_rsignal_f,de_rsignal_D,path,fs );

%低通滤波
Hd = Bottom_lowpass(fs,fc);
%Hd=lowpass_new(fs,fc);
lp_rsignal_d=filter(Hd,de_rsignal_d);
dedata=[];
lp_rsignal_d=lp_rsignal_d(1*Tbnumber+1:end);
% lp_rsignal_t=1/fs:1/fs:Tbnumber*(rsignal_num+1)*1/fs;
% [lp_rsignal_D,lp_rsignal_f]=Bottom_make_specturm(lp_rsignal_d,fs);
% Between_lp_resignal_picture( lp_rsignal_t,lp_rsignal_d,lp_rsignal_f,lp_rsignal_D,path,fs );

%抽样判决
for i=1:rsignal_num
   if  lp_rsignal_d(ceil((1.8+i-1)*Tbnumber))>0%短数据设置1.24；32bit、fc=969M,0.065;fc=70M,1.04;fc=35M,1.8;
       dedata=[dedata 1];
   else
       dedata=[dedata -1]; 
   end
end
end