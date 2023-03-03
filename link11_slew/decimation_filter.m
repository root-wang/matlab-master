function [ doutI , doutQ ] = decimation_filter( dinI , dinQ , speed_select)

load('fir_2400_400.mat');
I_400 = conv(dinI,fir_2400_400);
Q_400 = conv(dinQ,fir_2400_400);
I_400 = I_400(52+5:6:end-51);
Q_400 = Q_400(52+5:6:end-51);

load('fir_400_360.mat');
I_3600_up = upsample(I_400,9);
Q_3600_up = upsample(Q_400,9);
I_3600 = conv(I_3600_up,fir_400_360);
Q_3600 = conv(Q_3600_up,fir_400_360);
I_3600 = I_3600(58:end-57);
Q_3600 = Q_3600(58:end-57);
I_360 = I_3600(1:10:end);
Q_360 = Q_3600(1:10:end);

load('fir_360_180.mat')
I_180 = conv(I_360,fir_360_180);
Q_180 = conv(Q_360,fir_360_180);
I_180 = I_180(14:2:end-13);
Q_180 = Q_180(14:2:end-13);

load('fir_180_90.mat')
I_90 = conv(I_180,fir_180_90);
Q_90 = conv(Q_180,fir_180_90);
I_90 = I_90(12:2:end-11);
Q_90 = Q_90(12:2:end-11);

load('fir_360_720_2.mat')
I_720_up = upsample(I_360,2);
Q_720_up = upsample(Q_360,2);
I_720 = conv(I_720_up,fir_360_720);
Q_720 = conv(Q_720_up,fir_360_720);
I_720 = I_720(12:end-11);
Q_720 = Q_720(12:end-11);

switch speed_select
    case 0
        doutI = I_90;
        doutQ = Q_90;
    case 1
        doutI = I_180;
        doutQ = Q_180;
    case 2
        doutI = I_360;
        doutQ = Q_360;
    case 3
        doutI = I_720;
        doutQ = Q_720;
end

end

