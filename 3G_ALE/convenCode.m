function [enCodeData] = convenCode(ConstraintLength ,data)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
trellis = poly2trellis(ConstraintLength,[171,133]);%[91 121])10;
enCodeData = convenc(data,trellis);
end

