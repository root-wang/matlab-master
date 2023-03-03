function [ data_out ] = symbol_decision_8psk(Isam , Qsam)
%UNTITLED3 8PSK信号判决

tan_pi_8 = 424;%tan(pi/8)*1024

Icom = floor(Isam*tan_pi_8/2^10);
Qcom = floor(Qsam*tan_pi_8/2^10);

data_out = zeros(1,3*length(Isam));

for i = 1:length(Isam)
    if Isam(i) >= 0 && Qsam(i) >= 0 %第一象限
        if Qsam(i) <= Icom(i) && Isam(i) > Qcom(i)
            data_out(3*i-2:3*i) = [0 0 0];
        elseif Qsam(i) > Icom(i) && Isam(i) <= Qcom(i)
            data_out(3*i-2:3*i) = [0 1 1];
        else
            data_out(3*i-2:3*i) = [0 0 1];
        end           
    elseif Isam(i) < 0 && Qsam(i) >= 0 %第二象限
        if Qsam(i) <= -Icom(i) && -Isam(i) > Qcom(i)
            data_out(3*i-2:3*i) = [1 0 1];
        elseif Qsam(i) > -Icom(i) && -Isam(i) <= Qcom(i)
            data_out(3*i-2:3*i) = [0 1 1];
        else
            data_out(3*i-2:3*i) = [1 1 1];
        end 
    elseif Isam(i) < 0 && Qsam(i) < 0 %第三象限
        if Qsam(i) >= Icom(i) && Isam(i) < Qcom(i)
            data_out(3*i-2:3*i) = [1 0 1];
        elseif Qsam(i) < Icom(i) && Isam(i) >= Qcom(i)
            data_out(3*i-2:3*i) = [1 1 0];
        else
            data_out(3*i-2:3*i) = [1 0 0];
        end
    else %第四象限
        if -Qsam(i) <= Icom(i) && Isam(i) > -Qcom(i)
            data_out(3*i-2:3*i) = [0 0 0];
        elseif -Qsam(i) > Icom(i) && Isam(i) <= -Qcom(i)
            data_out(3*i-2:3*i) = [1 1 0];
        else
            data_out(3*i-2:3*i) = [0 1 0];
        end
    end
end

end

