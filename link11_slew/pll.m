function [ I , Q ] = pll( dataI , dataQ ,signal_type)
%UNTITLED2 
%  dataI & dataQ ：带相偏和频谱的输入信号   %12位有符号数，1位符号位%
%  I & Q ：锁相锁频后的输出信号



%signals initial
data_rec = zeros(1,length(dataI));
phase_err = zeros(1,length(dataI));
nco_out = zeros(1,length(dataI));   %cos(-0.125)--cos(0.125);sin(-0.125)--sin(0.125)。放大2^11倍后满幅。控制字取-1024--1024%
PLL_freq_part = zeros(1,length(dataI));
cos_phase_err = zeros(1,length(dataI));
sin_phase_err = zeros(1,length(dataI));

C1 = 0.0100;
C2 = 6.2832e-06;



%receive
for i = 18:length(dataI)+17
    data_rec(i) = (dataI(i-17)+1i*dataQ(i-17)).*exp(-1i*nco_out(i-17));  
	%----PD----%
    if abs(data_rec(i)) == 0
        phase_err(i) = 0;
    else
        switch signal_type
            case 0
                phase_err(i) = real(data_rec(i))*imag(data_rec(i))*(imag(data_rec(i))^2-real(data_rec(i))^2)/(abs(data_rec(i))^4);
            case 1
                phase_err(i) = real(data_rec(i))*imag(data_rec(i))*(imag(data_rec(i))^2-real(data_rec(i))^2)/(abs(data_rec(i))^4);
            case 2
                phase_err(i) = real(data_rec(i))*imag(data_rec(i))*(imag(data_rec(i))^2-real(data_rec(i))^2)/(abs(data_rec(i))^4);
            case 3
                sin_phase_err(i) = real(data_rec(i))*imag(data_rec(i))*(imag(data_rec(i))^2-real(data_rec(i))^2)...
                                    /(abs(data_rec(i))^4);
                cos_phase_err(i) = (1/2*real(data_rec(i))^2*imag(data_rec(i))^2-1/4*(imag(data_rec(i))^2-real(data_rec(i))^2)^2)...
                                    /(abs(data_rec(i))^4);
                phase_err(i) = cos_phase_err(i).*sin_phase_err(i);
        end
	    
    end
    %-----环路滤波-----%
    PLL_phase_part(i) = phase_err(i)*C1;
    Freq_ctrl(i) = PLL_phase_part(i) + PLL_freq_part(i-1);
    PLL_freq_part(i) = phase_err(i)*C2 + PLL_freq_part(i-1);
    
    nco_out(i) = nco_out(i-1) + Freq_ctrl(i);
end

I = real(data_rec(18:end));
Q = imag(data_rec(18:end));

% figure
% plot(nco_out,'b.-')
% title('1阶环路滤波器')
% xlabel('采样点数')
% ylabel('输入NCO的相位值')
% figure
% plot(cos(nco_out))
end

