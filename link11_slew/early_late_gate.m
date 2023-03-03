function [ Isam ,Qsam ] = early_late_gate( I_input , Q_input , N_sample )
%UNTITLED3 超前/滞后门位同步
%   I_input & Q_input : 输入。判决后未进行位同步的信号，双极性非归零码
%   Isam & Qsam : 输出。最佳采样点


d = 5;%滞后门相对超前门的延迟时钟，也就是信号码元宽度与超前/滞后门宽度的差值
len_gate = N_sample-d-5;%超前门和滞后门的宽度

I_input_sym = I_input>0;
I_input_sym = I_input_sym*2-1;
Q_input_sym = Q_input>0;
Q_input_sym = Q_input_sym*2-1;



early_gate = ones(1,len_gate)';%超前门
late_gate = ones(1,len_gate)';%滞后门

%signals initial
N = round(length(I_input)/N_sample);
deltaI = zeros(1,N+1);
uI1 = zeros(1,N);
uI2 = zeros(1,N);
uQ1 = zeros(1,N);
uQ2 = zeros(1,N);
Isam = zeros(1,N);
Qsam = zeros(1,N);
kI = ones(1,N);
k = 0;
for ii = 1:N-500
    
    uI1(ii) = I_input_sym(kI(ii):kI(ii)+len_gate-1)*early_gate;
    uI2(ii) = I_input_sym(kI(ii)+d:kI(ii)+d+len_gate-1)*late_gate;
    uQ1(ii) = Q_input_sym(kI(ii):kI(ii)+len_gate-1)*early_gate;
    uQ2(ii) = Q_input_sym(kI(ii)+d:kI(ii)+d+len_gate-1)*late_gate;
    
    clk_errI = (uI2(ii)-uI1(ii))*sign(uI1(ii)+uI2(ii));%时钟偏差
    clk_errQ = (uQ2(ii)-uQ1(ii))*sign(uQ1(ii)+uQ2(ii));%时钟偏差
    clk_err = clk_errI + clk_errQ;
%     a(ii) = clk_errI;

    
    
    if clk_err>8
        k = k+1;
    elseif clk_err<-8
        k = k-1;
%     elseif clk_errI == 0
%         if sign(uI1(ii)+uI2(ii))==0
%            k = k-1; 
%         end
    end

    
    Isam(ii) = floor((I_input(kI(ii)+5)));
    Qsam(ii) = floor((Q_input(kI(ii)+5)));
%     Isam(ii) = floor((I_input(kI(ii)+7)+I_input(kI(ii)+6))/2);
%     Qsam(ii) = floor((Q_input(kI(ii)+7)+Q_input(kI(ii)+6))/2);

     if k == 3
        deltaI(ii) = 1;
        k = 0;
     elseif  k == -3
        deltaI(ii) = -1; 
        k = 0;
     else
        deltaI(ii) = 0;
     end
%      deltaI(ii) = 0;
     kI(ii+1) = kI(ii)+N_sample+deltaI(ii);
 
end
% mean(a)
% mean(abs(a))

end

