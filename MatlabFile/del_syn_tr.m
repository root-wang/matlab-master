function [data_out]=del_syn_tr(data_in)
%ȥ��ͬ�����ţ��õ�0��1������
data_x=data_in(20*32+1:end);
data_out=(data_x+1)/2;
end