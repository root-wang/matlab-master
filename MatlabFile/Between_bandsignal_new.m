function [ bandsignal_d, bandsignal_num,bandsignal_t] = Between_bandsignal_new(ikk_d,qkk_d,fs,Tbnumber )
%累加同相、正交分量，获得频带信号
%ikk_d=[ikk_d, zeros(1,Tbnumber)];
bandsignal_d=ikk_d+qkk_d;
bandsignal_num=length(bandsignal_d)/Tbnumber;
bandsignal_t=1/fs:1/fs:Tbnumber*bandsignal_num*1/fs;
end
