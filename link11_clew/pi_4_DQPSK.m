function [output] = pi_4_DQPSK(input)

fc = 2000;
fs = 1800 * 4;
link11_clew = [];

Imod = [];
Qmod = [];

for i = 1:1000
    %%    �����任
    % series_2_parallel
    data_parallel = series_2_parallel(input);
    data_xk = data_parallel(1, :);
    data_yk = data_parallel(2, :);

    %%    ����ԭʼ���ؽ��в����λ����
    % diff_phase_encode
    diffPhaseEncodeData = diff_phase_encode(data_xk, data_yk);

    data_I = diffPhaseEncodeData(1, :);
    data_Q = diffPhaseEncodeData(2, :);

    %     scatter(data_I,data_Q);
    %     grid on;
    %%    �ϲ���
    % upsample
    data_upsample_I = upSample(data_I);
    data_upsample_Q = upSample(data_Q);


    %% �����ƫ Ƶƫ ˥�� ����
    % ˥��
    alpha =zeros(size(data_upsample_I),'like',data_upsample_I);
    val = rand();
    for i=1:length(alpha)
        alpha(i)=val;
    end

    %��ƫ
    delta_phase = [0*pi,1/4*pi,2/4*pi,3/4*pi,pi];
    select_idx = randi([1,5]);

    %Ƶƫ
    delta_freq = 0;

    fc_ac = fc+delta_freq;

    %%  ����
    time = 1:length(data_upsample_I);
    Imod = [Imod, alpha.*data_upsample_I .* cos(2 * pi * fc_ac .* time / fs+delta_phase(select_idx))];
    Qmod = [Qmod, -alpha.*data_upsample_Q .* sin(2 * pi * fc_ac .* time / fs)+delta_phase(select_idx)];
    link11_clew = Imod + Qmod;
end

% ����
Imod_n=zeros(size(Imod),'like',Imod);
Qmod_n=zeros(size(Qmod),'like',Qmod);


for i=1:length(Imod)/1024
   snr = randi([1,19]);
   Imod_n((i-1)*1024+1:i*1024)=awgn(Imod((i-1)*1024+1:i*1024),snr,'measured');
   Qmod_n((i-1)*1024+1:i*1024)=awgn(Qmod((i-1)*1024+1:i*1024),snr,'measured');
end

%% 
fidI = fopen('Link11_CLEW_I.txt', 'w');
fidQ = fopen('Link11_CLEW_Q.txt', 'w');
% len = length(Imod);
len = 4096000;

for i = 1:len

fprintf(fidI, '%s\r\n', Imod_n(i));
fprintf(fidQ, '%s\r\n', Qmod_n(i));
end

fclose(fidI);
fclose(fidQ);

figure;
subplot(211); plot(link11_clew(1:1024));
title('�ز�����ʱ����');
subplot(212); plot(abs(fft(link11_clew)));
title('�ز�����Ƶ����');

output = link11_clew;
end
