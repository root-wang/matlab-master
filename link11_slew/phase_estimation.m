function [ H ] = phase_estimation( modsignal )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
L = length(modsignal);
I = real(modsignal);
Q = imag(modsignal);
Ipos = I(Q>0);
I1 = Ipos(Ipos>0);
I2 = Ipos(Ipos<0);
Ineg = I(Q<0);
I3 = Ineg(Ineg<0);
I4 = Ineg(Ineg>0);
Qpos = Q(I>0);
Q1 = Qpos(Qpos>0);
Q4 = Qpos(Qpos<0);
Qneg = Q(I<0);
Q3 = Qneg(Qneg<0);
Q2 = Qneg(Qneg>0);
angreal = sum(sign(I1))/L+sum(sign(I2))/L-sum(sign(I3))/L-sum(sign(I4))/L;
angimag = sum(sign(Q1))/L-sum(sign(Q2))/L-sum(sign(Q3))/L+sum(sign(Q4))/L;
angle_H = (angreal+angimag)/2;
H = exp(-1i*angle_H*pi/4);
end

