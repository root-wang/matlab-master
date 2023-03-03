function [data_out]=del_syn_tr(data_in)
%去除同步符号，得到0，1比特流
data_x=data_in(20*32+1:end);
data_out=(data_x+1)/2;
end