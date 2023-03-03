function [CRCEncode] = CRC_encode(inpuData, poly)
    % ѭ������У�����
    % inputData ԭʼ���� bitstream
    % poly ����ʽϵ������

    % 1 X N�Ķ���ʽϵ��
    [M, N] = size(poly);
    % ���������ݺ���
    inpuDataPaddingZero = [inpuData, zeros(1, N - 1)];

    [q, r] = deconv(inpuDataPaddingZero, poly); %����ʽ����q��Ϊ�̣�rΪ��������Ϊʮ���ƶ���ʽ����
    r = abs(r);
    crc = mod(r, 2);
    CRCEncode = [inpuData, crc(length(inpuData) + 1:end)];

end
