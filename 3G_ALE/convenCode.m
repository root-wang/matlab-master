function [enCodeData] = convenCode(ConstraintLength ,data)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
trellis = poly2trellis(ConstraintLength,[171,133]);%[91 121])10;
enCodeData = convenc(data,trellis);
end

