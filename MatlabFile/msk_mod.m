function [ ikk_d,qkk_d] = msk_mod( data,fb,fc,fs)
%����MSK_new2�ļ��޸�
Tbnumber=ceil(fs/fb);
data_num=length(data);%��Ԫ����

%�����źŵĲ�ֱ���
[ difcoding] = Between_difcoding_new( data_num,data );%��ֱ���    %����1
difcoding_num=length(difcoding);%��Ԫ��=data_num

%�����źŵĴ���ת��
[ ~,sp ] = Between_sp_new( difcoding_num,difcoding);          %����2

%������ͬ������ź�
ik=sp(1,:);
ik=[1,ik];%����һ����ʼֵ�Ա�֤������λ����
ik_num=length(ik);
ik_t=1/fs:1/fs:Tbnumber*1/fs*ik_num;
ik_d=Between_NRZ(ik,Tbnumber).*cos(ik_t*pi/2*fb);             %����3
qk=sp(2,:);
qk=[1,qk];%����һ����ʼֵ�Ա�֤������λ����
qk_num=length(qk);
qk_t=1/fs:1/fs:Tbnumber*1/fs*(qk_num);
qk_d=Between_NRZ(qk,Tbnumber).*(-sin(qk_t*pi/2*fb));          %����3

% ˥��
alpha =zeros(size(ik_t),'like',ik_t);
val = rand();
for i=1:length(alpha)
    alpha(i)=val;
end


%��ƫ
delta_phase = [0*pi,1/4*pi,2/4*pi,3/4*pi,pi];
select_idx = randi([1,5]);
%Ƶƫ
delta_freq = 0;

fc_ac = fc+delta_freq;

%������ͬ��Ƶ���ź�
ikk_t=ik_t;
% ikk_d=ik_d.*cos(2*pi*fc*ikk_t);
ikk_d=alpha.*ik_d.*cos(2*pi*fc_ac*ikk_t+delta_phase(select_idx));
qkk_t=qk_t;
% qkk_d=qk_d.*sin(2*pi*fc*qkk_t);
qkk_d=alpha.*qk_d.*sin(2*pi*fc_ac*qkk_t+delta_phase(select_idx));   



%Ƶ���ź�
% ikk_d=ikk_d(Tbnumber+1:Tbnumber*ik_num);
% qkk_d=qkk_d(Tbnumber+1:Tbnumber*qk_num);
% [ bandsignal_d, ~,~] = Between_bandsignal_new(ikk_d,qkk_d,fs,Tbnumber );%����4

end