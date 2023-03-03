clc;
clear all;
close all;

%-----信号参数-----%
fc = 2000;
delta_phase = 0*pi;%相偏
delta_freq = 0;%频偏
fs = 2.4e9;
ts = 1/fs;
speed_select = 0;%0-22.5M;1-45M;2-90M;3-180M
signal_type = 3; %0-QPSK;1-OQSPK;2-UQPSK;3-8PSK
switch speed_select
    case 0
        Rs = 22.5e6;
    case 1
        Rs = 45e6;
    case 2
        Rs = 90e6;
    case 3
        Rs = 180e6;
end
N_data = 21000;
EbN0 = 15;

switch signal_type
    case 3
        SNR = EbN0+10*log10(3)-10*log10(fs/Rs);%dB
    otherwise
        SNR = EbN0+10*log10(2)-10*log10(fs/Rs);%dB
end

for  ii = 1:length(SNR)
    sum_err = 0;
    for jj = 1:1
%%     %----------基带信号产生----------%
        load('Link11_SLEW.mat');
        data = Link11_SLEW(1:N_data);
        [Isym , Qsym] = pskmapping(data,signal_type);%映射
%%     %----------成型滤波-----------%
        Izero = upsample(Isym,4);
        Qzero = upsample(Qsym,4);
        psf = rcosdesign(0.35,8,4,'sqrt');
        Ipulse = conv(Izero,psf);
        Qpulse = conv(Qzero,psf);
        switch signal_type
            case 1
                Ipulse = Ipulse(17:end-14);
                Qpulse = Qpulse(15:end-16);
            otherwise
                Ipulse = Ipulse(17:end-16);
                Qpulse = Qpulse(17:end-16); 
        end
%%     %----------上采样-----------%    
        switch speed_select
            case 0%90M->720M
                Iup = upsample(Ipulse,8);
                Qup = upsample(Qpulse,8);
                load('fir_90_720.mat');
                Iup = conv(Iup,fir_90_720);
                Qup = conv(Qup,fir_90_720);
                Iup = Iup(21:end-20);
                Qup = Qup(21:end-20);
            case 1%180M->720M
                Iup = upsample(Ipulse,4);
                Qup = upsample(Qpulse,4);
                load('fir_180_720.mat');
                Iup = conv(Iup,fir_180_720);
                Qup = conv(Qup,fir_180_720);
                Iup = Iup(11:end-10);
                Qup = Qup(11:end-10);
            case 2%360M->720M
                Iup = upsample(Ipulse,2);
                Qup = upsample(Qpulse,2);
                load('fir_360_720.mat');
                Iup = conv(Iup,fir_360_720);
                Qup = conv(Qup,fir_360_720);
                Iup = Iup(11:end-10);
                Qup = Qup(11:end-10);
            case 3%720M
                Iup = Ipulse;
                Qup = Qpulse;
        end
        Iup2 = upsample(Iup,10);
        Qup2 = upsample(Qup,10);
        load('fir_720_7200.mat');
        Iup2 = conv(Iup2,fir_720_7200);
        Qup2 = conv(Qup2,fir_720_7200);
        Iup2 = Iup2(26:end-25);
        Qup2 = Qup2(26:end-25);
        Ipulm = Iup2(1:3:end);
        Qpulm = Qup2(1:3:end);
%%     %---------上变频------------%
        fc_ac = fc+delta_freq; %加频偏
        phase = delta_phase;       %加相偏
        t1 = 0:ts:ts*length(Ipulm)-ts;
        Imod = Ipulm.*cos(2*pi*fc_ac*t1+phase);%2.4GHz采样率 1.8GHz载波 22.5MHz符号速率
        Qmod = -Qpulm.*sin(2*pi*fc_ac*t1+phase);
        signal = Imod+Qmod;  %12位有符号数，1位符号位%
        fidI=fopen('Link11_SLEW_I.txt','w');
        fidQ=fopen('Link11_SLEW_Q.txt','w');
        len = length(Imod);
        len = 409600;
        for i = 1:len
            
        fprintf(fidI,'%s\r\n',Imod(i));
        fprintf(fidQ,'%s\r\n',Qmod(i));
        end
        fclose(fidI);
        fclose(fidQ);
%%     %---------加噪---------%
        SNR(ii) = SNR(ii) + 10*log10(2);%实信号混频后基带信号能量会减半
        signal = awgn(signal,SNR(ii),'measured');
        signal = fix(signal/max(abs(signal))*1000*2^4);
%%      %---混频---%
        Imix = signal.*cos(2*pi*fc*t1);%2.4GHz采样下进行混频
        Qmix = -signal.*sin(2*pi*fc*t1);
%%      %---抽取滤波---%
        [Idec , Qdec] = decimation_filter(Imix,Qmix,speed_select);
%%      %---锁相锁频环---%
        [Iout , Qout] = pll(Idec,Qdec,signal_type);
%%      %---匹配滤波---%
        mtf = rcosdesign(0.5,8,4,'sqrt');
        Imat = conv(Iout,mtf);
        Qmat = conv(Qout,mtf);
        switch signal_type
            case 1
                Iarr = Imat(17:end-18);
                Qarr = Qmat(19:end-16);
            otherwise
                Iarr = Imat(17:end-16);
                Qarr = Qmat(17:end-16);
        end
%%      %----添加时钟偏差----%
        Iclk = Iarr;
        Qclk = Qarr;
%%      %----位同步----%
        I_16 = upsample(Iclk,4);
        Q_16 = upsample(Qclk,4);
        load('fir_4_16');
        I_16 = conv(I_16,fir_4_16);
        Q_16 = conv(Q_16,fir_4_16);
        I_16 = I_16(24:end-24);
        Q_16 = Q_16(24:end-24);
        [Isam , Qsam] = gardner_sync(I_16,Q_16,16);
%         [Isam,Qsam] = early_late_gate(I_16,Q_16,16);
        switch signal_type
            case 2
                for iiii = 1:2
                    Hest = phase_estimation(Isam+1i*Qsam);
                    S = (Isam+1i*Qsam)*Hest;
                    Isam = real(S);
                    Qsam = imag(S);
                end
            otherwise
        end
%         scatterplot(Isam(end/2:end)+1i*Qsam(end/2:end))
%%     %----判决----%
        switch signal_type
            case 3
                final = symbol_decision_8psk(Isam , Qsam);
            otherwise
                final = symbol_decision_qpsk(Isam , Qsam);
        end
%%     %---------误码率------------%
        sum_err = sum_err+sum(abs(final(end*0.5:end)-data(end*0.5:end)));%误码统计
    end
    
    err_rate(ii) = sum_err/(N_data-200)/jj;        

end
% figure
% semilogy(EbN0,err_rate)
% grid on
% xlabel('Eb/N0(dB)')
% ylabel('BER')
% axis([3 15 0 1])