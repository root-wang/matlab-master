function [CRCEncode] = CRC_encode(inpuData, poly)
    % 循环冗余校验编码
    % inputData 原始数据 bitstream
    % poly 多项式系数向量

    % 1 X N的多项式系数
    [M, N] = size(poly);
    % 将输入数据后补零
    inpuDataPaddingZero = [inpuData, zeros(1, N - 1)];

    [q, r] = deconv(inpuDataPaddingZero, poly); %多项式除法q中为商，r为余数，此为十进制多项式除法
    r = abs(r);
    crc = mod(r, 2);
    CRCEncode = [inpuData, crc(length(inpuData) + 1:end)];

end
