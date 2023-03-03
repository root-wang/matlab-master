function [ ikk_d,qkk_d] = msk_mod( data,fb,fc,fs)
%根据MSK_new2文件修改
Tbnumber=ceil(fs/fb);
data_num=length(data);%码元个数

%基带信号的差分编码
[ difcoding] = Between_difcoding_new( data_num,data );%差分编码    %函数1
difcoding_num=length(difcoding);%码元数=data_num

%基带信号的串并转换
[ ~,sp ] = Between_sp_new( difcoding_num,difcoding);          %函数2

%正交、同相基带信号
ik=sp(1,:);
ik=[1,ik];%补充一个初始值以保证波形相位连续
ik_num=length(ik);
ik_t=1/fs:1/fs:Tbnumber*1/fs*ik_num;
ik_d=Between_NRZ(ik,Tbnumber).*cos(ik_t*pi/2*fb);             %函数3
qk=sp(2,:);
qk=[1,qk];%补充一个初始值以保证波形相位连续
qk_num=length(qk);
qk_t=1/fs:1/fs:Tbnumber*1/fs*(qk_num);
qk_d=Between_NRZ(qk,Tbnumber).*(-sin(qk_t*pi/2*fb));          %函数3

% 衰减
alpha =zeros(size(ik_t),'like',ik_t);
val = rand();
for i=1:length(alpha)
    alpha(i)=val;
end


%相偏
delta_phase = [0*pi,1/4*pi,2/4*pi,3/4*pi,pi];
select_idx = randi([1,5]);
%频偏
delta_freq = 0;

fc_ac = fc+delta_freq;

%正交、同相频带信号
ikk_t=ik_t;
% ikk_d=ik_d.*cos(2*pi*fc*ikk_t);
ikk_d=alpha.*ik_d.*cos(2*pi*fc_ac*ikk_t+delta_phase(select_idx));
qkk_t=qk_t;
% qkk_d=qk_d.*sin(2*pi*fc*qkk_t);
qkk_d=alpha.*qk_d.*sin(2*pi*fc_ac*qkk_t+delta_phase(select_idx));   



%频带信号
% ikk_d=ikk_d(Tbnumber+1:Tbnumber*ik_num);
% qkk_d=qkk_d(Tbnumber+1:Tbnumber*qk_num);
% [ bandsignal_d, ~,~] = Between_bandsignal_new(ikk_d,qkk_d,fs,Tbnumber );%函数4

end